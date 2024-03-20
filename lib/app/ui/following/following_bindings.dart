import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/following/following_controller.dart';

class FollowingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowingController>(() => FollowingController());
  }
}
