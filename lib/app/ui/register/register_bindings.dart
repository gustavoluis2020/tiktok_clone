import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/register/register_controller.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
