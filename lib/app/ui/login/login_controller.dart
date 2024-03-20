import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/utils/auth_error.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> loginKey = GlobalKey<FormState>(debugLabel: 'loginKey');

  void login() async {
    isLoading.value = true;
    final isValidForm = loginKey.currentState!.validate();

    if (isValidForm) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        await Future.delayed(const Duration(seconds: 2));
        Get.offAllNamed(Routes.homePage);
        isLoading.value = false;
      } on FirebaseException catch (error) {
        String? message = error.code;
        if (AuthErrors.errorMessages[error.code] != null) {
          message = AuthErrors.errorMessages[error.code];
        }
        isLoading.value = false;
        Get.defaultDialog(
          radius: 5,
          title: 'Ops',
          middleText: message ?? 'Erro ao Tentar realizar login',
        );
      } on PlatformException catch (error) {
        isLoading.value = false;
        Get.defaultDialog(radius: 5, title: 'Erro', middleText: error.message ?? 'Erro ao Tentar realizar o Login');
      }
    } else {
      // Get.defaultDialog(
      //   radius: 5,
      //   title: 'Atenção!!!',
      //   content: const Text('Preencha todos os campos corretamente!'),
      // );

      isLoading.value = false;
    }
    isLoading.value = false;
  }
}
