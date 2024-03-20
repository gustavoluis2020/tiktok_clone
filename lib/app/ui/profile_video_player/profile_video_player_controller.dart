import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/models/video_model.dart';

class ProfileVideoController extends GetxController {
  final Rx<List<VideoModel>> videoFileList = Rx<List<VideoModel>>([]);
  List<VideoModel> get clickedVideoFile => videoFileList.value;

  final Rx<String> _videoID = ''.obs;
  String get clickedVideoID => _videoID.value;

  @override
  void onInit() {
    super.onInit();
    getClickedVideoInfo();
    // pegando os argumentos vindo da profile page ref a cada video clicado do usuario
    // que esta me seguindo, a função readClickedThumbailInfo  dentro do profile controller que envia
    // o thumabinail de cada video
    final arguments = Get.arguments;
    if (arguments != null) {
      _videoID.value = arguments;
    }
  }

  setVideoID(String vID) {
    _videoID.value = vID;
  }

  getClickedVideoInfo() {
    videoFileList.bindStream(
      FirebaseFirestore.instance.collection("videos").snapshots().map(
        (QuerySnapshot snapshotQuery) {
          List<VideoModel> videoList = [];

          for (var eachVideo in snapshotQuery.docs) {
            if (eachVideo['videoID'] == clickedVideoID) {
              videoList.add(
                VideoModel.fromDocumentSnapshot(eachVideo),
              );
            }
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
