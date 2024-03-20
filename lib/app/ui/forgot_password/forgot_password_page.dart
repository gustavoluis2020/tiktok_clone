import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/forgot_password/forgot_password_controller.dart';
import 'package:tiktok_clone/app/utils/validations.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: controller.forgotKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  const Text(
                    'Esqueceu sua senha?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Get.height * .1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3), // Define a posição da sombra (horizontal, vertical)
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              'Digite seu email para recuperar sua senha.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),
                            InputTextField(
                              model: InputTextFieldModel(
                                controller: controller.emailController,
                                text: 'Email',
                                isPassword: false,
                                type: TextInputType.emailAddress,
                                validator: Validations.emailValidator,
                                formatters: [],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Obx(() {
                              return ButtonEnter(
                                onTap: controller.forgotPassword,
                                isLoading: controller.isLoading.value,
                                titleButton: 'Enviar',
                              );
                            }),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  IconButton(
                    onPressed: () {
                      Get.offAllNamed(Routes.login);
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 60, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
