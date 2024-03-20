import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:tiktok_clone/app/ui/profile_video_player/profile_video_player_controller.dart';
import 'package:tiktok_clone/app/utils/circular_widget_animation.dart';
import 'package:tiktok_clone/app/utils/custom_video_player.dart';

class ProfileVideoPlayerPage extends GetView<ProfileVideoController> {
  const ProfileVideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            itemCount: controller.clickedVideoFile.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final clickedVideoInfo = controller.clickedVideoFile[index];
              return Stack(
                children: [
                  CustomVideoPlayer(
                    videoFileUrl: clickedVideoInfo.videoUrl.toString(),
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
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: const Text(
                                        "Voltar",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "@${clickedVideoInfo.userName}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      clickedVideoInfo.descriptionTags.toString(),
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
                                            clickedVideoInfo.titleVideo.toString(),
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
                                                  clickedVideoInfo.userProfileImage.toString(),
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
                                          controller.likeOrUnlikeVideo(clickedVideoInfo.videoID.toString());
                                        },
                                        icon: Icon(
                                          Icons.favorite_rounded,
                                          size: 40,
                                          color: clickedVideoInfo.likesList!
                                                  .contains(FirebaseAuth.instance.currentUser!.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          clickedVideoInfo.likesList!.length.toString(),
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
                                            arguments: clickedVideoInfo.videoID.toString(),
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
                                          clickedVideoInfo.totalComments!.toString(),
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
                                          clickedVideoInfo.totalShares!.toString(),
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
                                                  clickedVideoInfo.userProfileImage.toString(),
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
