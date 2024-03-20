import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field.dart';
import 'package:tiktok_clone/app/components/text_field/input_text_field_model.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/settings/settings_controller.dart';
import 'package:tiktok_clone/app/utils/validations.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        init: SettingsController(),
        builder: (context) {
          if (controller.userMap.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const Text(
                'Configurações',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primary,
                ),
                onPressed: () => Get.offNamed(Routes.profilePage),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: controller.settingsKey,
                child: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          dialogSelectedImage();
                        },
                        child: CircleAvatar(
                          radius: 80,
                          backgroundImage: controller.imageFile == null
                              ? NetworkImage(controller.userMap["userImage"] ?? '')
                              : Image.file(controller.imageFile!).image,
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          readOnly: true,
                          controller: controller.emailController,
                          text: 'Email',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: controller.userNameController,
                          text: 'Nome',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: controller.facebookController,
                          text: 'Facebook',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: controller.instagramController,
                          text: 'Instagram',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: controller.twitterController,
                          text: 'Twitter',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      InputTextField(
                        model: InputTextFieldModel(
                          controller: controller.youtubeController,
                          text: 'Youtube',
                          isPassword: false,
                          type: TextInputType.text,
                          validator: Validations.nameValidator,
                          formatters: [],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return ButtonEnter(
                          onTap: controller.updateUser,
                          isLoading: controller.isLoading.value,
                          titleButton: 'Salvar Alterações',
                        );
                      }),
                    ],
                  )),
                ),
              ),
            ),
          );
        });
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
                backgroundColor: Colors.black,
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
                backgroundColor: Colors.black,
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
