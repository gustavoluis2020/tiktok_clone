import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tiktok_clone/app/ui/profile/components/profile_shimmer_page.dart';
import 'package:tiktok_clone/app/ui/profile/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (context) {
        if (controller.userMap.isEmpty) {
          return const ProfileShimmerPage();
        }
        return Scaffold(
          bottomNavigationBar: BottomNavBar(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              controller.userMap["userName"],
              style: const TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              controller.userId2 == controller.uidFire
                  ? PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                      color: Colors.grey[100],
                      onSelected: controller.handleClickEvent,
                      itemBuilder: (BuildContext context) {
                        return {
                          'Configurações',
                          'Sair',
                        }.map((String choiceClicked) {
                          return PopupMenuItem(
                            value: choiceClicked,
                            child: Text(
                              choiceClicked,
                              style: const TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList();
                      },
                    )
                  : Container(),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(controller.userMap["userImage"]),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.followingsPage,
                              arguments: controller.userMap["userUID"],
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                controller.userMap["totalFollowings"].toString(),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Followings',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 2,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            Routes.followersPage,
                            arguments: controller.userMap["userUID"],
                          );
                        },
                        child: Column(
                          children: [
                            Text(
                              controller.userMap["totalFallowers"].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Fallowers',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        width: 2,
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: [
                            Text(
                              controller.userMap["totalLikes"].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Curtidas',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (controller.userMap["userFacebook"] == '') {
                          } else {
                            controller.launchUserSocialProfile(controller.userMap["userFacebook"]);
                          }
                        },
                        child: Image.asset(
                          "assets/images/facebook.png",
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          if (controller.userMap["userInstagram"] == '') {
                          } else {
                            controller.launchUserSocialProfile(controller.userMap["userInstagram"]);
                          }
                        },
                        child: Image.asset(
                          "assets/images/instagram.png",
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          if (controller.userMap["userTwitter"] == '') {
                          } else {
                            controller.launchUserSocialProfile(controller.userMap["userTwitter"]);
                          }
                        },
                        child: Image.asset(
                          "assets/images/twitter.png",
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          if (controller.userMap["userYoutube"] == '') {
                          } else {
                            controller.launchUserSocialProfile(controller.userMap["userYoutube"]);
                          }
                        },
                        child: Image.asset(
                          "assets/images/youtube.png",
                          width: 50,
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () {
                        controller.checkUnAndFollowUser();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 90),
                        shape: controller.userId2 == controller.uidFire
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(color: Colors.black, width: 2),
                              )
                            // ignore: unrelated_type_equality_checks
                            : controller.isFollowingUser == true
                                ? RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: Colors.blue, width: 2),
                                  )
                                : RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(color: Colors.red, width: 2),
                                  ),
                      ),
                      child: Text(
                        controller.userId2 == controller.uidFire
                            ? 'Sair'
                            // ignore: unrelated_type_equality_checks
                            : controller.isFollowingUser == true
                                ? 'Deixar de Seguir'
                                : 'Seguir',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.userMap['thumbnailsList'].length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: .7, crossAxisSpacing: 2),
                    itemBuilder: (context, index) {
                      String eachThumbnail = controller.userMap['thumbnailsList'][index];
                      return GestureDetector(
                        onTap: () {
                          controller.readClickedThumbailInfo(eachThumbnail);
                        },
                        child: Image.network(
                          eachThumbnail,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
