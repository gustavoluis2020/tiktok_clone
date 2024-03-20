import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
