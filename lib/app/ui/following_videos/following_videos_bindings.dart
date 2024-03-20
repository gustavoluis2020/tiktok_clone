import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/following_videos/following_videos_controller.dart';

class FollowingVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FollowingVideosController>(() => FollowingVideosController());
  }
}
