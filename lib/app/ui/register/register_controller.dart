import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/models/user_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> registerKey = GlobalKey<FormState>(debugLabel: 'registerKey');

  RxBool isLoading = false.obs;

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

  void register() async {
    isLoading.value = true;
    final isValidForm = registerKey.currentState!.validate();

    if (isValidForm && imageFile != null) {
      try {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);
        String imageDownloadUrl = await uploadImageToStorage(imageFile!);
        UserModel user = UserModel(
          name: nameController.text,
          email: emailController.text,
          image: imageDownloadUrl,
          uid: credential.user!.uid,
        );

        await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
        Get.offAllNamed(Routes.homePage);
        isLoading.value = false;
      } on FirebaseAuthException catch (error) {
        isLoading.value = false;

        String message = error.message ?? 'Erro ao Tentar realizar login';

        if (error.code == "email-already-in-use") {
          message = "Ops, parece que este email já está sendo utilizado em outra conta.";
        }
        Get.defaultDialog(title: 'Erro', middleText: message);
      } on PlatformException catch (error) {
        isLoading.value = false;
        Get.defaultDialog(title: 'Erro', middleText: error.message ?? 'Erro ao Tentar realizar o cadastro');
      }
    } else {
      Get.defaultDialog(
          radius: 5,
          title: 'Atenção!!!',
          content: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image.asset('assets/images/camera2.png'),
                const SizedBox(height: 20),
                const Text(
                  'Clique na Imagem e selecione uma foto para seu perfil e preencha todos os campos corretamente.',
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ));

      isLoading.value = false;
    }
  }

  Future<String> uploadImageToStorage(File imageFile) async {
    Reference reference = FirebaseStorage.instance.ref().child('Profile Images').child(
          FirebaseAuth.instance.currentUser!.uid,
        );
    UploadTask uploadTask = reference.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrlofUploadImage = await taskSnapshot.ref.getDownloadURL();

    return downloadUrlofUploadImage;
  }

  Future<void> login() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 5));
    isLoading.value = false;
  }
}
