import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/app/ui/following_videos/following_videos_page.dart';
import 'package:tiktok_clone/app/ui/home/home_page.dart';
import 'package:tiktok_clone/app/ui/profile/profile_page.dart';
import 'package:tiktok_clone/app/ui/search/search_page.dart';
import 'package:tiktok_clone/app/ui/upload_videos/components/upload_form.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_page.dart';

// abstract class NavigationTabs {
//   static const int home = 0;
//   static const int search = 1;
//   static const int add = 2;
//   static const int follow = 3;
//   static const int profile = 4;
// }

class BottomNavController extends GetxController {
  RxInt screenIndex = 0.obs;

  List screenList = [
    const HomePage(),
    const SearchPage(),
    const UploadVideosPage(),
    const FollowingVideosPage(),
    const ProfilePage()
  ];

  RxBool isLoading = false.obs;

  // upload video
  getVideoFile(ImageSource sourceImg) async {
    final videoFile = await ImagePicker().pickVideo(source: sourceImg);

    if (videoFile != null) {
      Get.to(UploadForm(
        videoFile: File(videoFile.path),
        videoPath: videoFile.path,
      ));
    }
  }

// outra forma de fazer usando listview
  // late PageController _pageController;
  // late RxInt _currentIndex;

  // PageController get pageController => _pageController;
  // int get currentIndex => _currentIndex.value;

  // @override
  // void onInit() {
  //   super.onInit();
  //   initiNavigation(
  //       pageController: PageController(initialPage: NavigationTabs.home), currentIndex: NavigationTabs.home);
  // }

  // void initiNavigation({
  //   required PageController pageController,
  //   required int currentIndex,
  // }) {
  //   _pageController = pageController;
  //   _currentIndex = currentIndex.obs;
  // }

  // void navigatePageView(int page) {
  //   if (_currentIndex.value == page) return;
  //   _pageController.animateToPage(
  //     page,
  //     duration: const Duration(microseconds: 900),
  //     curve: Curves.ease,
  //   );
  //   _currentIndex.value = page;
  // }
}
