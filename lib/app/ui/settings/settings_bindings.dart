import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/settings/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
