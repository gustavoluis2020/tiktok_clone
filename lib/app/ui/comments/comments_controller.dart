import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/models/comment_model.dart';

class CommentsController extends GetxController {
  TextEditingController commentTextEditingController = TextEditingController();
  String currentVideoID = '';
  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null) {
      currentVideoID = arguments;
    }
    retrieveComments();
  }

  saveNewCommentToDatabase() async {
    if (commentTextEditingController.text.isNotEmpty) {
      try {
        String commentID = DateTime.now().millisecondsSinceEpoch.toString();
        DocumentSnapshot snapshotUserDocument =
            await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

        CommentModel commentModel = CommentModel(
          userName: (snapshotUserDocument.data() as dynamic)["name"],
          userID: FirebaseAuth.instance.currentUser!.uid,
          userProfileImage: (snapshotUserDocument.data() as dynamic)["image"],
          commentText: commentTextEditingController.text,
          commentID: commentID,
          commentLikesList: [],
          publishedDateTime: DateTime.now(),
        );
        commentTextEditingController.clear();
        // save data in firebase
        await FirebaseFirestore.instance
            .collection("videos")
            .doc(currentVideoID)
            .collection("comments")
            .doc(commentID)
            .set(
              commentModel.toJson(),
            );

        DocumentSnapshot currentVideoSnapshotDocument =
            await FirebaseFirestore.instance.collection("videos").doc(currentVideoID).get();

        await FirebaseFirestore.instance
            .collection("videos")
            .doc(currentVideoID)
            .update({"totalComments": (currentVideoSnapshotDocument.data() as dynamic)["totalComments"] + 1});
      } catch (errorMsg) {
        Get.snackbar('Algo deu Errado', errorMsg.toString());
      }
    } else {
      Get.snackbar('Algo deu Errado', 'Faça um comentario!');
    }
  }

  // get de uid user
  String uid = FirebaseAuth.instance.currentUser!.uid;

  final Rx<List<CommentModel>> commentsList = Rx<List<CommentModel>>([]);
  List<CommentModel> get listOfComments => commentsList.value;

  RxList<CommentModel> commentsList2 = RxList<CommentModel>([]); // tentar assim depois
  // se mudar onde tem commentsList pela lista commentsList2 e
  // mudar tambem onde tem listOfComments  pela mesma lista commentsList2 tambem funciona ok

  retrieveComments() async {
    //get the comments made and display on the screen
    // cod abaixo ele acessa os comentarios com query o for percorre cada comentario
    // um a um e armazena na lista commentsListOfVideo
    commentsList.bindStream(
      FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .orderBy("publishedDateTime", descending: true)
          .snapshots()
          .map((QuerySnapshot commentsSnapshot) {
        List<CommentModel> commentsListOfVideo = [];
        for (var eachComment in commentsSnapshot.docs) {
          commentsListOfVideo.add(CommentModel.fromSnap(eachComment));
        }
        return commentsListOfVideo;
      }),
    );
  }

  likeUnLikeComment(String commentID) async {
    DocumentSnapshot commentDocumentsSnapshot = await FirebaseFirestore.instance
        .collection("videos")
        .doc(currentVideoID)
        .collection("comments")
        .doc(commentID)
        .get();

    if ((commentDocumentsSnapshot.data() as dynamic)["commentLikesList"].contains(uid)) {
      // remove like
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .doc(commentID)
          .update({
        "commentLikesList": FieldValue.arrayRemove([uid]),
      });
      // add like
    } else {
      await FirebaseFirestore.instance
          .collection("videos")
          .doc(currentVideoID)
          .collection("comments")
          .doc(commentID)
          .update({
        "commentLikesList": FieldValue.arrayUnion([uid]),
      });
    }
  }

  // delete comments and update de total comments in home page
  deleteComment(String commentID) async {
    await FirebaseFirestore.instance
        .collection("videos")
        .doc(currentVideoID)
        .collection("comments")
        .doc(commentID)
        .delete();

    //
    DocumentSnapshot currentVideoSnapshotDocument =
        await FirebaseFirestore.instance.collection("videos").doc(currentVideoID).get();

    // get de total comments and update with subtract - 1
    await FirebaseFirestore.instance
        .collection("videos")
        .doc(currentVideoID)
        .update({"totalComments": (currentVideoSnapshotDocument.data() as dynamic)["totalComments"] - 1});
  }
}
