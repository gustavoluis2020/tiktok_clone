import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/profile_video_player/profile_video_player_controller.dart';

class ProfileVideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileVideoController>(() => ProfileVideoController());
  }
}
