// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String? userID;
  String? userName;
  String? userProfileImage;
  String? videoID;
  int? totalComments;
  int? totalShares;
  List? likesList;
  String? titleVideo;
  String? descriptionTags;
  String? videoUrl;
  String? thumbnailUrl;
  int? publishedDateTime;
  VideoModel({
    this.userID,
    this.userName,
    this.userProfileImage,
    this.videoID,
    this.totalComments,
    this.totalShares,
    this.likesList,
    this.titleVideo,
    this.descriptionTags,
    this.videoUrl,
    this.thumbnailUrl,
    this.publishedDateTime,
  });

  Map<String, dynamic> toJson() => {
        "userID": userID,
        "userName": userName,
        "userProfileImage": userProfileImage,
        "videoID": videoID,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "likesList": likesList,
        "titleVideo": titleVideo,
        "descriptionTags": descriptionTags,
        "videoUrl": videoUrl,
        "thumbnailUrl": thumbnailUrl,
        "publishedDateTime": publishedDateTime,
      };

  static VideoModel fromDocumentSnapshot(DocumentSnapshot snapshot) {
    var docSnapshot = snapshot.data() as Map<String, dynamic>;

    return VideoModel(
      userID: docSnapshot["userID"],
      userName: docSnapshot["userName"],
      userProfileImage: docSnapshot["userProfileImage"],
      videoID: docSnapshot["videoID"],
      totalComments: docSnapshot["totalComments"],
      totalShares: docSnapshot["totalShares"],
      likesList: docSnapshot["likesList"],
      titleVideo: docSnapshot["titleVideo"],
      descriptionTags: docSnapshot["descriptionTags"],
      videoUrl: docSnapshot["videoUrl"],
      thumbnailUrl: docSnapshot["thumbnailUrl"],
      publishedDateTime: docSnapshot["publishedDateTimee"],
    );
  }
}
