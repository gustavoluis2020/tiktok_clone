import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/components/button_enter.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/bottom_nav_controller.dart';

// ignore: must_be_immutable
class AddPage extends StatelessWidget {
  AddPage({super.key});
  BottomNavController controller = Get.put(BottomNavController());
  @override
  Widget build(BuildContext context) {
    //BottomNavController controller = Get.put(BottomNavController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.upload_file_outlined,
              color: Colors.black,
              size: 200,
            ),
            const SizedBox(height: 50),
            ButtonEnter(
              isLoading: controller.isLoading.value,
              titleButton: 'Enviar Novo Video',
              onTap: () {
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
                            controller.getVideoFile(ImageSource.camera);
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
              },
            ),
          ],
        ),
      ),
    );
  }

  // void dialogSelectedVideo() {
  //   Get.defaultDialog(
  //     title: '',
  //     radius: 5,
  //     content: SizedBox(
  //       height: 190,
  //       width: Get.width,
  //       child: Column(
  //         children: [
  //           const Text(
  //             'Selecionar Video:',
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
  //           ),
  //           const SizedBox(height: 20),
  //           ElevatedButton.icon(
  //             onPressed: () {
  //               // controller.getVideoFile(ImageSource.gallery);
  //             },
  //             icon: const Icon(Icons.photo),
  //             label: const Text('Galeria'),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.black,
  //               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           const Text(
  //             'OU',
  //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
  //           ),
  //           const SizedBox(height: 10),
  //           ElevatedButton.icon(
  //             onPressed: () {
  //               //    controller.getVideoFile(ImageSource.camera);
  //             },
  //             icon: const Icon(Icons.photo_camera),
  //             label: const Text('Camera'),
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.black,
  //               padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(5),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
