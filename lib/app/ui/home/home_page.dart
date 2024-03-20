import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/components/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:tiktok_clone/app/utils/circular_widget_animation.dart';
import 'package:tiktok_clone/app/utils/custom_video_player.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: Obx(() {
        return PageView.builder(
            itemCount: controller.forYouAllVideosList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final eachVideo = controller.forYouAllVideosList[index];
              return Stack(
                children: [
                  CustomVideoPlayer(
                    videoFileUrl: eachVideo.videoUrl.toString(),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 120),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 22),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "@${eachVideo.userName}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      eachVideo.descriptionTags.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.title_rounded,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            eachVideo.titleVideo.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: Get.height / 4),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    width: 62,
                                    height: 62,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 4,
                                          child: Container(
                                            width: 52,
                                            height: 52,
                                            padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                color: Colors.white, borderRadius: BorderRadius.circular(25)),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: Image(
                                                image: NetworkImage(
                                                  eachVideo.userProfileImage.toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.likeOrUnlikeVideo(eachVideo.videoID.toString());
                                        },
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          size: 40,
                                          color: eachVideo.likesList!.contains(FirebaseAuth.instance.currentUser!.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          eachVideo.likesList!.length.toString(),
                                          style: const TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.commentsPage,
                                            arguments: eachVideo.videoID.toString(),
                                          );
                                          //  Get.to(CommentsPage2(videoID: eachVideo.videoID.toString()));
                                        },
                                        icon: const Icon(
                                          Icons.add_comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          eachVideo.totalComments!.toString(),
                                          style: const TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.share,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          eachVideo.totalShares!.toString(),
                                          style: const TextStyle(fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CircularImageAnimation(
                                    widgetAnimation: SizedBox(
                                      width: 62,
                                      height: 62,
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(12),
                                            height: 52,
                                            width: 52,
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(colors: [
                                                Colors.grey,
                                                Colors.white,
                                              ]),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: Image(
                                                image: NetworkImage(
                                                  eachVideo.userProfileImage.toString(),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      }),
    );
  }
}
