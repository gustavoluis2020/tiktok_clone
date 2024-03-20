import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/models/video_model.dart';

class FollowingVideosController extends GetxController {
  final Rx<List<VideoModel>> followingsVideosList = Rx<List<VideoModel>>([]);
  List<VideoModel> get followingsAllVideosList => followingsVideosList.value;

  List<String> followingKeysList = [];
  var currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();
  @override
  void onInit() {
    super.onInit();
    getFollowingUsersVideos();
  }

  getFollowingUsersVideos() async {
    var followingDocument =
        await FirebaseFirestore.instance.collection('users').doc(currentUserID).collection('following').get();

    for (int i = 0; i < followingDocument.docs.length; i++) {
      followingKeysList.add(followingDocument.docs[i].id);
    }

    followingsVideosList.bindStream(
      FirebaseFirestore.instance.collection("videos").orderBy('publishedDateTime', descending: true).snapshots().map(
        (QuerySnapshot snapshotVideos) {
          List<VideoModel> followingPersonVideos = [];
          for (var eachVideo in snapshotVideos.docs) {
            for (int i = 0; i < followingKeysList.length; i++) {
              String followingPersonID = followingKeysList[i];
              if (eachVideo['userID'] == followingPersonID) {
                followingPersonVideos.add(
                  VideoModel.fromDocumentSnapshot(eachVideo),
                );
              }
            }
          }
          return followingPersonVideos;
        },
      ),
    );
  }

  likeOrUnlikeVideo(String videoID) async {
    DocumentSnapshot snapshotDoc = await FirebaseFirestore.instance.collection("videos").doc(videoID).get();

    if ((snapshotDoc.data() as dynamic)["likesList"].contains(currentUserID)) {
      await FirebaseFirestore.instance.collection("videos").doc(videoID).update({
        "likesList": FieldValue.arrayRemove([currentUserID])
      });
    } else {
      await FirebaseFirestore.instance.collection("videos").doc(videoID).update({
        "likesList": FieldValue.arrayUnion([currentUserID])
      });
    }
  }
}
