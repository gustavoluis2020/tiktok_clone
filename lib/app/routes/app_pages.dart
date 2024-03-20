import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/bottom_nav_bindings.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/bottom_nav_pages.dart';
import 'package:tiktok_clone/app/ui/comments/comments_bindings.dart';
import 'package:tiktok_clone/app/ui/comments/comments_page.dart';
import 'package:tiktok_clone/app/ui/followers/followers_bindings.dart';
import 'package:tiktok_clone/app/ui/followers/followers_page.dart';
import 'package:tiktok_clone/app/ui/following/following_bindings.dart';
import 'package:tiktok_clone/app/ui/following/following_page.dart';
import 'package:tiktok_clone/app/ui/following_videos/following_videos_bindings.dart';
import 'package:tiktok_clone/app/ui/following_videos/following_videos_page.dart';
import 'package:tiktok_clone/app/ui/forgot_password/forgot_password_bindings.dart';
import 'package:tiktok_clone/app/ui/forgot_password/forgot_password_page.dart';
import 'package:tiktok_clone/app/ui/home/home_bindings.dart';
import 'package:tiktok_clone/app/ui/home/home_page.dart';
import 'package:tiktok_clone/app/ui/login/login_bindings.dart';
import 'package:tiktok_clone/app/ui/login/login_page.dart';
import 'package:tiktok_clone/app/ui/profile/profile_bindings.dart';
import 'package:tiktok_clone/app/ui/profile/profile_page.dart';
import 'package:tiktok_clone/app/ui/profile_video_player/profile_video_player_bindings.dart';
import 'package:tiktok_clone/app/ui/profile_video_player/profile_video_player_page.dart';
import 'package:tiktok_clone/app/ui/register/register_bindings.dart';
import 'package:tiktok_clone/app/ui/register/register_page.dart';
import 'package:tiktok_clone/app/ui/search/search_bindings.dart';
import 'package:tiktok_clone/app/ui/search/search_page.dart';
import 'package:tiktok_clone/app/ui/settings/settings_bindings.dart';
import 'package:tiktok_clone/app/ui/settings/settings_page.dart';
import 'package:tiktok_clone/app/ui/splash/splash_bindings.dart';
import 'package:tiktok_clone/app/ui/splash/splash_page.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_bindings.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_page.dart';

class AppPages {
  // ignore: constant_identifier_names

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginPage(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.bottomNavPages,
      page: () => const BottomNavPages(),
      binding: BottomNavBinding(),
    ),
    GetPage(
      name: Routes.uploadVideosPage,
      page: () => const UploadVideosPage(),
      binding: UploadVideosBinding(),
    ),
    GetPage(
      name: Routes.homePage,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.commentsPage,
      page: () => const CommentsPage(),
      binding: CommentsBinding(),
    ),
    GetPage(
      name: Routes.profilePage,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.searchPage,
      page: () => const SearchPage(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: Routes.profileVideoPlayerPage,
      page: () => const ProfileVideoPlayerPage(),
      binding: ProfileVideoPlayerBinding(),
    ),
    GetPage(
      name: Routes.followingsPage,
      page: () => const FollowingPage(),
      binding: FollowingBinding(),
    ),
    GetPage(
      name: Routes.followersPage,
      page: () => const FollowersPage(),
      binding: FollowersBinding(),
    ),
    GetPage(
      name: Routes.followingVideoPage,
      page: () => const FollowingVideosPage(),
      binding: FollowingVideosBinding(),
    ),
    GetPage(
      name: Routes.settingsPage,
      page: () => const SettingsPage(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.forgotPasswordPage,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
  ];
}
