import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/bottom_nav_controller.dart';
import 'package:tiktok_clone/app/ui/comments/comments_controller.dart';
import 'package:tiktok_clone/app/ui/following_videos/following_videos_controller.dart';
import 'package:tiktok_clone/app/ui/home/home_controller.dart';
import 'package:tiktok_clone/app/ui/profile/profile_controller.dart';
import 'package:tiktok_clone/app/ui/search/search_controller.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_controller.dart';

class BottomNavBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavController>(() => BottomNavController());
    Get.lazyPut<UploadVideosController>(() => UploadVideosController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CommentsController>(() => CommentsController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<SearchController2>(() => SearchController2(), fenix: true);
    Get.lazyPut<FollowingVideosController>(() => FollowingVideosController(), fenix: true);
  }
}
