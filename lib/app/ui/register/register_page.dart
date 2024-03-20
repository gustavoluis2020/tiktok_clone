import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/register/register_controller.dart';
import 'package:tiktok_clone/app/utils/validations.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final passFocus = FocusNode();
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
              key: controller.registerKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/video2.png',
                    height: 200,
                  ),
                  const SizedBox(height: 10),
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
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                dialogSelectedImage();
                              },
                              child: GetBuilder<RegisterController>(builder: (_) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(color: AppColors.grey600, width: 1),
                                  ),
                                  child: ClipOval(
                                    child: controller.imageFile == null
                                        ? SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                              'assets/images/camera2.png',
                                            ),
                                          )
                                        : Image.file(
                                            controller.imageFile!,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 30),
                            InputTextField(
                              model: InputTextFieldModel(
                                controller: controller.nameController,
                                text: 'Nome',
                                isPassword: false,
                                type: TextInputType.text,
                                validator: Validations.nameValidator,
                                formatters: [],
                                onFieldSubmitted: (_) {
                                  passFocus.requestFocus();
                                },
                                disableCheckIcon: false,
                              ),
                            ),
                            const SizedBox(height: 20),
                            InputTextField(
                              model: InputTextFieldModel(
                                // readOnly: true,
                                controller: controller.emailController,
                                focusNode: passFocus,
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
                                focusNode: passFocus,
                                isPassword: true,
                                type: TextInputType.visiblePassword,
                                validator: Validations.passwordRegisterValidator,
                                formatters: [],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Obx(() {
                              return ButtonEnter(
                                onTap: controller.register,
                                isLoading: controller.isLoading.value,
                                titleButton: 'Cadastrar',
                              );
                            }),
                            const SizedBox(
                              height: 5,
                            ),
                            const Stack(
                              alignment: Alignment.center,
                              children: [
                                Divider(
                                  color: AppColors.grey900,
                                ),
                                Chip(
                                  label: Text(
                                    'OU',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              ],
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Já possui Cadastro?',
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
                                        Get.offNamed(Routes.login);
                                      },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dialogSelectedImage() {
    Get.defaultDialog(
      title: '',
      radius: 5,
      content: SizedBox(
        height: 190,
        width: Get.width,
        child: Column(
          children: [
            const Text(
              'Selecionar Imagem:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.getImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.photo),
              label: const Text('Galeria'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'OU',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                controller.getImage(ImageSource.camera);
              },
              icon: const Icon(Icons.photo_camera),
              label: const Text('Camera'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
