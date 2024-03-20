import 'package:get/get.dart';

import 'package:tiktok_clone/app/ui/search/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController2>(() => SearchController2());
  }
}
