import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? userName;
  String? commentText;
  String? userProfileImage;
  String? userID;
  String? commentID;
  DateTime? publishedDateTime;
  List? commentLikesList;

  CommentModel({
    this.userName,
    this.commentText,
    this.userProfileImage,
    this.userID,
    this.commentID,
    this.publishedDateTime,
    this.commentLikesList,
  });

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "commentText": commentText,
        "userProfileImage": userProfileImage,
        "userID": userID,
        "commentID": commentID,
        "publishedDateTime": publishedDateTime,
        "commentLikesList": commentLikesList,
      };

  static CommentModel fromSnap(DocumentSnapshot snapshot) {
    var documentSnapshot = snapshot.data() as Map<String, dynamic>;

    return CommentModel(
      userName: documentSnapshot["userName"] ?? '',
      commentText: documentSnapshot["commentText"] ?? '',
      userProfileImage: documentSnapshot["userProfileImage"] ?? '',
      userID: documentSnapshot["email"] ?? '',
      commentID: documentSnapshot["commentID"] ?? '',
      publishedDateTime: (documentSnapshot["publishedDateTime"] as Timestamp).toDate(),
      commentLikesList: documentSnapshot["commentLikesList"] ?? [],
    );
  }
}
