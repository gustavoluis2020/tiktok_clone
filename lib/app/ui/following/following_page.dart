import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tiktok_clone/app/ui/following/following_controller.dart';
import '../../routes/app_routes.dart';
import 'components/following_page_shimmer.dart';

class FollowingPage extends GetView<FollowingController> {
  const FollowingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FollowingController>(
      init: FollowingController(),
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Column(
              children: [
                controller.loadingUserData.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 20,
                          width: 120,
                        ),
                      )
                    : Text(
                        controller.userMap["userName"].toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                const SizedBox(height: 5),
                controller.loadingUserData.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: 20,
                          width: 80,
                        ),
                      )
                    : Text(
                        'Seguindo ${controller.userMap["totalFollowings"].toString()}',
                        style: const TextStyle(color: Colors.black),
                      ),
              ],
            ),
          ),
          body: Obx(
            () {
              return controller.loadingFollowing.value
                  ? const FollowingPageShimmer()
                  : controller.followingUserDataList.isEmpty
                      ? const Center(child: Icon(Icons.person_off_sharp, color: Colors.black, size: 60))
                      : ListView.builder(
                          itemCount: controller.followingUserDataList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, top: 4),
                              child: Card(
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      Routes.profilePage,
                                    );
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        controller.followingUserDataList[index]['image'].toString(),
                                      ),
                                    ),
                                    title: Text(
                                      controller.followingUserDataList[index]['name'].toString(),
                                      style: const TextStyle(fontSize: 18, color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      controller.followingUserDataList[index]['email'].toString(),
                                      style: const TextStyle(fontSize: 18, color: Colors.black),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.navigate_next_outlined,
                                        size: 24,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
            },
          ),
        );
      },
    );
  }
}
