import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/ui/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            'assets/images/camera.png',
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
    );
  }
}
