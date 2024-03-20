import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final auth = FirebaseAuth.instance;

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(const Duration(seconds: 2));

    validateUser();
  }

  void validateUser() async {
    if (auth.currentUser != null) {
      Get.offAllNamed(Routes.homePage);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
