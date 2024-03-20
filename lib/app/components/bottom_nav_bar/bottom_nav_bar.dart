import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/components/colors/colors_app.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/components/bottom_nav_bar/bottom_nav_item.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({
    super.key,
  });

  final int currentIndex = 0;

  final items = [
    BottomNavItem.home(),
    BottomNavItem.search(),
    BottomNavItem.add(),
    BottomNavItem.following(),
    BottomNavItem.profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.primary,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: items.indexWhere((element) => element.route == Get.currentRoute),
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.black,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (Get.currentRoute == items[index].route) return;
          final route = items[index].route == '' ? Routes.homePage : items[index].route;
          if (Get.currentRoute == route) return;
          Get.offAllNamed(route);
        },
        items: List.generate(items.length, (index) {
          bool itemActive = Get.currentRoute == items[index].route;
          return BottomNavigationBarItem(
            label: '',
            icon: Column(
              children: [
                Icon(
                  itemActive ? items[index].iconActive : items[index].icon,
                  size: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  items[index].title,
                  style: TextStyle(
                    color: itemActive ? AppColors.primary : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
