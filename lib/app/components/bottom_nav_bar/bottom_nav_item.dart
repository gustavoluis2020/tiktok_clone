import 'package:flutter/material.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';

enum BottomNavItemType {
  home,
  search,
  add,
  following,
  profile,
}

class BottomNavItem {
  const BottomNavItem._({
    required this.title,
    required this.icon,
    required this.iconActive,
    required this.type,
    required this.route,
  });

  final String title;
  final IconData icon;
  final IconData iconActive;
  final BottomNavItemType type;
  final String route;

  factory BottomNavItem.home() {
    return const BottomNavItem._(
      title: 'Home',
      icon: Icons.home,
      iconActive: Icons.home,
      type: BottomNavItemType.home,
      route: Routes.homePage,
    );
  }

  factory BottomNavItem.search() {
    return const BottomNavItem._(
      title: 'Busca',
      icon: Icons.search,
      iconActive: Icons.search,
      type: BottomNavItemType.search,
      route: Routes.searchPage,
    );
  }

  factory BottomNavItem.add() {
    return const BottomNavItem._(
      title: 'Add',
      icon: Icons.add,
      iconActive: Icons.add,
      type: BottomNavItemType.add,
      route: Routes.uploadVideosPage,
    );
  }

  factory BottomNavItem.following() {
    return const BottomNavItem._(
      title: 'Seguindo',
      icon: Icons.inbox_sharp,
      iconActive: Icons.inbox_sharp,
      type: BottomNavItemType.following,
      route: Routes.followingVideoPage,
    );
  }

  factory BottomNavItem.profile() {
    return const BottomNavItem._(
      title: 'Perfil',
      icon: Icons.person,
      iconActive: Icons.person,
      type: BottomNavItemType.profile,
      route: Routes.profilePage,
    );
  }
}
