// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SettingsController extends GetxController {
  GlobalKey<FormState> settingsKey = GlobalKey<FormState>(debugLabel: 'settingsKey');

  RxBool isLoading = false.obs;

  String userUID = FirebaseAuth.instance.currentUser!.uid;

  String facebook = "";
  String instagram = "";
  String twitter = "";
  String youtube = "";
  String userImageUrl = "";
  String userName = "";
  String email = "";

  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final Rx<Map<String, dynamic>> _userMap = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userMap => _userMap.value;

  getCurrentUserData() async {
    DocumentSnapshot snapshotUser = await FirebaseFirestore.instance.collection('users').doc(userUID).get();

    final userInfo = snapshotUser.data() as dynamic;

    String userImage = userInfo["image"] ?? '';

    _userMap.value = {
      "userImage": userImage,
    };

    facebook = snapshotUser['facebook'] ?? "";
    instagram = snapshotUser['instagram'] ?? '';
    twitter = snapshotUser['twitter'] ?? '';
    youtube = snapshotUser['youtube'] ?? '';
    userImageUrl = snapshotUser['image'] ?? '';
    userName = snapshotUser['name'] ?? '';
    email = snapshotUser['email'] ?? '';

    facebookController.text = facebook == null ? "" : facebook;
    instagramController.text = instagram == null ? "" : instagram;
    twitterController.text = twitter == null ? "" : twitter;
    youtubeController.text = youtube == null ? "" : youtube;
    userNameController.text = userName == null ? "" : userName;
    emailController.text = email == null ? "" : email;
    userImageUrl = userImageUrl == null ? "" : userImageUrl;

    update();
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentUserData();
  }

  updateUser() async {
    isLoading.value = true;

    if (imageFile != null) {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      String imageDownloadUrl = await uploadImageToStorage(imageFile!);

      await FirebaseFirestore.instance.collection('users').doc(userUID).update({
        'facebook': facebookController.text,
        'instagram': instagramController.text,
        'twitter': twitterController.text,
        'youtube': youtubeController.text,
        'name': userNameController.text,
        'image': imageDownloadUrl,
      });
    } else {
      await Future.delayed(const Duration(seconds: 2));
      isLoading.value = false;
      await FirebaseFirestore.instance.collection('users').doc(userUID).update({
        'facebook': facebookController.text,
        'instagram': instagramController.text,
        'twitter': twitterController.text,
        'youtube': youtubeController.text,
        'name': userNameController.text,
      });
      isLoading.value = false;
    }
  }

  File? imageFile;

  void getImage(ImageSource imageSource) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: imageSource);

    if (pickedFile != null) {
      cropImage(pickedFile.path);
      update();
      Get.back();
    } else {
      Get.back();
    }
  }

  void cropImage(filePath) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: filePath, maxHeight: 1080, maxWidth: 1080);
    if (croppedImage != null) {
      imageFile = File(croppedImage.path);
      update();
    }
    update();
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance.ref().child('Profile Images').child(
          FirebaseAuth.instance.currentUser!.uid,
        );
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrlofUploadImage = await taskSnapshot.ref.getDownloadURL();
    update();
    return downloadUrlofUploadImage;
  }
}
