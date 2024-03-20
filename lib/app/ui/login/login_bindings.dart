import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/login/login_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
