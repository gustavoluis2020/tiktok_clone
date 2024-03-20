import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_controller.dart';

class UploadVideosPage extends GetView<UploadVideosController> {
  const UploadVideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.upload_file_outlined,
              color: AppColors.primary,
              size: 200,
            ),
            const SizedBox(height: 50),
            ButtonEnter(
              isLoading: controller.isLoading.value,
              titleButton: 'Enviar Novo Video',
              onTap: () {
                dialogSelectedVideo();
              },
            ),
          ],
        ),
      ),
    );
  }

  void dialogSelectedVideo() {
    Get.defaultDialog(
      title: '',
      radius: 5,
      content: SizedBox(
        height: 190,
        width: Get.width,
        child: Column(
          children: [
            const Text(
              'Selecionar Video:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                controller.getVideoFile(ImageSource.gallery);
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
                controller.getVideoFile(ImageSource.camera);
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
