import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FollowersController extends GetxController {
  final Rx<Map<String, dynamic>> _userMap = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userMap => _userMap.value;

  final Rx<String> _userID = ''.obs;

  final RxBool loadingUserData = false.obs;

  final RxBool loadingFollowers = false.obs;

  List<String> followersKeysList = [];
  RxList followersUserDataList = [].obs;

  @override
  void onInit() {
    super.onInit();

    final arguments = Get.arguments;
    if (arguments != null) {
      _userID.value = arguments;
    }

    getFollowersListKeys();
    retrieveUserInformation();
  }

  getFollowersListKeys() async {
    var followingDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('followers').get();

    for (int i = 0; i < followingDocument.docs.length; i++) {
      followersKeysList.add(followingDocument.docs[i].id);
    }

    getFollowingKeysDataFromUserCollection(followersKeysList);
  }

  getFollowingKeysDataFromUserCollection(List<String> listOfFollowersKeys) async {
    loadingFollowers.value = true;
    var allUsersDocument = await FirebaseFirestore.instance.collection('users').get();
    loadingFollowers.value = false;
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      for (int j = 0; j < listOfFollowersKeys.length; j++) {
        if (((allUsersDocument.docs[i].data() as dynamic)['uid']) == listOfFollowersKeys[j]) {
          followersUserDataList.add((allUsersDocument.docs[i].data()));
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
