import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/comments/comments_controller.dart';

class CommentsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentsController>(() => CommentsController());
  }
}
