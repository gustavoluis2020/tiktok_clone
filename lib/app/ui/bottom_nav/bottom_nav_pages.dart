import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/bottom_nav_controller.dart';
import 'package:tiktok_clone/app/ui/bottom_nav/upload_custom_icon.dart';

class BottomNavPages extends GetView<BottomNavController> {
  const BottomNavPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          currentIndex: controller.screenIndex.value, //controller.currentIndex,
          onTap: (index) {
            controller.screenIndex.value = index;
            //controller.navigatePageView(index);

            // );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Busca',
            ),
            BottomNavigationBarItem(
              icon: UploadCustomIcon(),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inbox_sharp),
              label: 'Seguindo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
        body: controller.screenList[controller.screenIndex.value],
        // outra forma de fazer
        // body: PageView(
        //   physics: const NeverScrollableScrollPhysics(),
        //   controller: controller.pageController,
        //   children: const [HomePage2(), SearchPage(), AddPage(), FollowPage(), ProfilePage()],
        // ),
      );
    });
  }
}
