import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/followers/followers_controller.dart';

class FollowersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowersController>(() => FollowersController());
  }
}
