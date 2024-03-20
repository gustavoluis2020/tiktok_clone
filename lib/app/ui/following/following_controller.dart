import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class FollowingController extends GetxController {
  final Rx<Map<String, dynamic>> _userMap = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userMap => _userMap.value;

  final Rx<String> _userID = ''.obs;

  final RxBool loadingUserData = false.obs;

  final RxBool loadingFollowing = false.obs;

  List<String> followingKeysList = [];
  RxList followingUserDataList = [].obs;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null) {
      _userID.value = arguments;
    }

    getFollowingListKeys();
    retrieveUserInformation();
  }

  getFollowingListKeys() async {
    var followingDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('following').get();

    for (int i = 0; i < followingDocument.docs.length; i++) {
      followingKeysList.add(followingDocument.docs[i].id);
    }

    getFollowingKeysDataFromUserCollection(followingKeysList);
  }

  getFollowingKeysDataFromUserCollection(List<String> listOfFollowingKeys) async {
    loadingFollowing.value = true;
    var allUsersDocument = await FirebaseFirestore.instance.collection('users').get();
    loadingFollowing.value = false;
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int j = 0; j < listOfFollowingKeys.length; j++) {
        if (((allUsersDocument.docs[i].data() as dynamic)['uid']) == listOfFollowingKeys[j]) {
          followingUserDataList.add((allUsersDocument.docs[i].data()));
        }
      }
    }
  }

  retrieveUserInformation() async {
    loadingUserData.value = true;
    DocumentSnapshot userDocumentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(_userID.value).get();

    loadingUserData.value = false;
    final userInfo = userDocumentSnapshot.data() as dynamic;

    String userName = userInfo["name"] ?? '';
    String userEmail = userInfo["email"] ?? '';
    String userImage = userInfo["image"] ?? '';
    String userUID = userInfo["uid"] ?? '';
    String userYoutube = userInfo["youtube"] ?? '';
    String userInstagram = userInfo["instagram"] ?? '';
    String userTwitter = userInfo["twitter"] ?? '';
    String userFacebook = userInfo["facebook"] ?? '';

    int totalLikes = 0;
    int totalFallowers = 0;
    int totalFollowings = 0;
    bool isFollowing = false;
    List<String> thumbnailsList = [];

    var followersNumDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('followers').get();
    totalFallowers = followersNumDocument.docs.length;

    var followingsNumDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('following').get();
    totalFollowings = followingsNumDocument.docs.length;

    _userMap.value = {
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userUID": userUID,
      "userYoutube": userYoutube,
      "userInstagram": userInstagram,
      "userTwitter": userTwitter,
      "userFacebook": userFacebook,
      "totalLikes": totalLikes.toString(),
      "totalFallowers": totalFallowers.toString(),
      "totalFollowings": totalFollowings.toString(),
      "isFollowing": isFollowing,
      "thumbnailsList": thumbnailsList,
    };
    update();
  }
}
