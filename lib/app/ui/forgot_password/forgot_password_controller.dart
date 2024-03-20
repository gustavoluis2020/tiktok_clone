import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> forgotKey = GlobalKey<FormState>(debugLabel: 'forgotKey');

  final auth = FirebaseAuth.instance;

  void forgotPassword() async {
    isLoading.value = true;
    final isValidForm = forgotKey.currentState!.validate();

    if (isValidForm) {
      try {
        await auth.sendPasswordResetEmail(email: emailController.text);

        await Future.delayed(const Duration(seconds: 2));

        isLoading.value = false;

        Get.defaultDialog(
          barrierDismissible: true,
          radius: 5,
          titlePadding: const EdgeInsets.only(
            top: 20,
          ),
          title: 'Verifique seu Email!',
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              children: [
                SizedBox(height: 10, width: Get.width),
                const Text(
                  'Enviamos o link para alterar sua senha!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Icon(Icons.email, color: AppColors.primary, size: 60),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ButtonEnter(
                    onTap: () {
                      Get.offAllNamed(Routes.login);
                    },
                    isLoading: false,
                    titleButton: 'Voltar',
                  ),
                ),
              ],
            ),
          ),
        );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case 'invalid-email':
            Get.defaultDialog(
              radius: 5,
              title: 'Ops',
              middleText: 'Email Invalido',
            );
            break;
          case 'user-not-found':
            Get.defaultDialog(
              radius: 5,
              title: 'Ops',
              middleText: 'Usuario não encontrado',
            );
            break;
          default:
            Get.defaultDialog(
              radius: 5,
              title: 'Ops',
              middleText: 'Ocorreu algum erro!',
            );
        }
      } catch (error) {
        Get.defaultDialog(
          radius: 5,
          title: 'Ops',
          middleText: 'Ocorreu algum erro!',
        );
      }
    }

    isLoading.value = false;
  }
}
