import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/upload_videos/upload_videos_controller.dart';

class UploadVideosBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadVideosController>(() => UploadVideosController());
  }
}
