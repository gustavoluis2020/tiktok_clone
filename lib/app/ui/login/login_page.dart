import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/login/login_controller.dart';
import 'package:tiktok_clone/app/utils/validations.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

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
              key: controller.loginKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Image.asset(
                    'assets/images/video3.png',
                    height: 200,
                  ),
                  SizedBox(height: Get.height * .07),
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
                            InputTextField(
                              model: InputTextFieldModel(
                                controller: controller.passwordController,
                                text: 'Senha',
                                isPassword: true,
                                type: TextInputType.visiblePassword,
                                validator: Validations.passwordValidator,
                                formatters: [],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  Get.offNamed(Routes.forgotPasswordPage);
                                },
                                child: const Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Obx(() {
                              return ButtonEnter(
                                onTap: controller.login,
                                isLoading: controller.isLoading.value,
                              );
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                ),
                                Chip(
                                  label: Text(
                                    'OU',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Não possui Cadastro?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '  Clique Aqui!',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        //  Get.toNamed(Routes.register);
                                        Get.offNamed(Routes.register);
                                      },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
