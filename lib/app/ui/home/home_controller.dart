import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/models/video_model.dart';

class HomeController extends GetxController {
  final Rx<List<VideoModel>> forYouVideosList = Rx<List<VideoModel>>([]);
  List<VideoModel> get forYouAllVideosList => forYouVideosList.value;

  @override
  void onInit() {
    super.onInit();

    forYouVideosList.bindStream(
      FirebaseFirestore.instance.collection("videos").orderBy("totalComments", descending: true).snapshots().map(
        (QuerySnapshot snapshotQuery) {
          List<VideoModel> videoList = [];

          for (var eachVideo in snapshotQuery.docs) {
            videoList.add(
              VideoModel.fromDocumentSnapshot(eachVideo),
            );
          }

          return videoList;
        },
      ),
    );
  }

  likeOrUnlikeVideo(String videoID) async {
    var currentUserID = FirebaseAuth.instance.currentUser!.uid.toString();

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
