import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/models/video_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/upload_videos/components/upload_form.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideosController extends GetxController {
  RxBool isLoading = false.obs;

  ///upload video
  getVideoFile(ImageSource sourceImg) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);

    if (videoFile != null) {
      Get.to(UploadForm(
        videoFile: File(videoFile.path),
        videoPath: videoFile.path,
      ));
    }
  }

  compressVideoFile(String videoFilePath) async {
    final compressdVideoFilePath = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

    return compressdVideoFilePath!.file;
  }

  uploadCompressedVideoFileToFirebaseStorage(String videoId, String videoFilePath) async {
    UploadTask videoUploadTask = FirebaseStorage.instance
        .ref()
        .child('All Videos')
        .child(videoId)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

    String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedVideo;
  }

  getThumbnailImage(String videoFilePath) async {
    final thumbnailImage = await VideoCompress.getFileThumbnail(videoFilePath);
    return thumbnailImage;
  }

  uploadThumbnailImageToFirebaseStorage(String videoId, String videoFilePath) async {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance
        .ref()
        .child('All Thumbnails')
        .child(videoId)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlOfUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedThumbnail;
  }

  saveVideoInformationToFirebaseDatabase(
      String titleVideo, String descriptionTags, String videoFilePath, BuildContext context) async {
    isLoading.value = true;
    try {
      DocumentSnapshot userDocumentSnapshot =
          await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
      String videoID = DateTime.now().millisecondsSinceEpoch.toString();

      String videoDownloadUrl = await uploadCompressedVideoFileToFirebaseStorage(videoID, videoFilePath);

      String thumbnailDownloadUrl = await uploadThumbnailImageToFirebaseStorage(videoID, videoFilePath);

      VideoModel videoObject = VideoModel(
        userID: FirebaseAuth.instance.currentUser!.uid,
        userName: (userDocumentSnapshot.data() as Map<String, dynamic>)["name"],
        userProfileImage: (userDocumentSnapshot.data() as Map<String, dynamic>)["image"],
        videoID: videoID,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        titleVideo: titleVideo,
        descriptionTags: descriptionTags,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );
      await FirebaseFirestore.instance.collection("videos").doc(videoID).set(videoObject.toJson());
      Get.offAllNamed(Routes.homePage);

      isLoading.value = false;
    } catch (errorMsg) {
      Get.snackbar('$errorMsg', 'Erro');
      Get.offAllNamed(Routes.homePage);
      isLoading.value = false;
    }
  }
}
