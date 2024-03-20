import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  // map abaixo criado para receber as informações da função retrieveUserInformation()
  // sendo assim quando precisar de um dos dados abaixo basta chamar o map
  // userMap["userName"] pq todas as informações estarão dentro do map
  //
  final Rx<Map<String, dynamic>> _userMap = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get userMap => _userMap.value;
  // Rx<String> _userID = ''.obs;
  final Rx<String> _userID = ''.obs;

  RxBool isFollowingUser = false.obs;

  RxBool isLoadingExit = false.obs;

  @override
  void onInit() {
    super.onInit();

// no caso abaixo vc recebe argumentos vindo da search page, quando vc busca um usuario e entra no profile
// dele, se vc nao for por la o arguments e nulo sendo assim ele pega o uid do firebase
// se vir pela nav bar e clicar em perfil vc acessa sem arguments entao vai pega o uid do firebase

    // final dynamic arguments = Get.arguments;

    // if (arguments is RxList<dynamic>) {
    //   _userID.value = arguments[0];
    // } else if (arguments is Map<String, dynamic>) {
    //   _userID.value = arguments['searchId'];
    // } else if (arguments is String) {
    //   _userID.value = arguments;
    // } else {
    //   _userID.value = FirebaseAuth.instance.currentUser!.uid;
    // }

    final arguments = Get.arguments;
    if (arguments != null) {
      _userID.value = arguments;
    } else {
      _userID.value = FirebaseAuth.instance.currentUser!.uid;
    }

    updateCurrentUserID(_userID.value.toString());
    getIsFollowingValue();
  }

  // final arguments = Get.arguments as Map<String, dynamic>?;
  // if (arguments != null) {
  //   _userID.value = arguments['searchId'];
  // } else {
  //   _userID.value = FirebaseAuth.instance.currentUser!.uid;
  // }

  // final arguments2 = Get.arguments as List<String>?;
  // if (arguments2 != null) {
  //   _userID.value = arguments2[0];
  // } else {
  //   _userID.value = FirebaseAuth.instance.currentUser!.uid;
  // }
  // String? uid = arguments2?[0];

  // final arguments = Get.arguments['searchId'];
  // if (arguments != null) {
  //   _userID.value = arguments;
  // } else {
  //   _userID.value = FirebaseAuth.instance.currentUser!.uid;
  // }

  // final arguments2 = Get.arguments['followingId'];
  // if (arguments2 != null) {
  //   _userID.value = arguments2;
  // } else {
  //   _userID.value = FirebaseAuth.instance.currentUser!.uid;
  // }

  //  updateCurrentUserID(FirebaseAuth.instance.currentUser!.uid);

  String get userId2 => _userID.value;
  String uidFire = FirebaseAuth.instance.currentUser!.uid;

  // ENVIAR PARA TELA PROFILE VIDEO PLAYER O VIDEO DE UM SEGUIDOR PARAVC PODER ASSISTIR
  readClickedThumbailInfo(String clickedThumbailInfo) async {
    var allVideosDocs = await FirebaseFirestore.instance.collection('videos').get();
    for (int i = 0; i < allVideosDocs.docs.length; i++) {
      if (((allVideosDocs.docs[i].data() as dynamic)['thumbnailUrl']) == clickedThumbailInfo) {
        Get.toNamed(Routes.profileVideoPlayerPage, arguments: (allVideosDocs.docs[i].data() as dynamic)['videoID']);
      }
    }
  }

  updateCurrentUserID(String visitUserID) {
    _userID.value = visitUserID;
    retrieveUserInformation(); // esse metodo pode ser chamado no onInit direto
    // com isso ele vai chamar as informações para mostrar na tela de perfil
  }

  retrieveUserInformation() async {
    DocumentSnapshot userDocumentSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(_userID.value).get();

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
    update();
    //get users videos info
    var currentVideos = await FirebaseFirestore.instance
        .collection('videos')
        .orderBy('publishedDateTime', descending: true)
        .where('userID', isEqualTo: _userID.value)
        .get();

    for (int i = 0; i < currentVideos.docs.length; i++) {
      thumbnailsList.add(
        (currentVideos.docs[i].data() as dynamic)['thumbnailUrl'],
      );
    }

    //get total number of likes
    for (var eachVideo in currentVideos.docs) {
      totalLikes = totalLikes + (eachVideo.data()['likesList'] as List).length;
    }

    var followersNumDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('followers').get();
    totalFallowers = followersNumDocument.docs.length;

    var followingsNumDocument =
        await FirebaseFirestore.instance.collection('users').doc(_userID.value).collection('following').get();
    totalFollowings = followingsNumDocument.docs.length;

    // checa se vc ja esta na lista de seguidores dos seus seguidores
    FirebaseFirestore.instance
        .collection('users')
        .doc(_userID.value)
        .collection('followers')
        .doc(uidFire)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

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

  handleClickEvent(String choiceClicked) {
    switch (choiceClicked) {
      case "Configurações":
        Get.offNamed(Routes.settingsPage);
        break;
      case "Sair":
        signOut();
        break;
    }
  }

  void signOut() async {
    isLoadingExit.value = true;
    try {
      await FirebaseAuth.instance.signOut();
      Get.offNamed(Routes.splash);
      isLoadingExit.value = false;
    } catch (e) {
      Get.snackbar('Erro', '{$e Ocorreu um erro, tente novamente }');
    }
    isLoadingExit.value = true;
  }

  Future<void> launchUserSocialProfile(String socialLink) async {
    if (!await launchUrl(Uri.parse("https://$socialLink"))) {
      throw Exception("Não foi possivel abrir o link  $socialLink");
    }
  }

  followUnFollowUser() async {
    //1. currentUser = already logged-in online user
    //2. other user = [visitor's profile]
    var document = await FirebaseFirestore.instance
        .collection('users')
        .doc(_userID.value)
        .collection('followers')
        .doc(uidFire)
        .get();
    //currentUser is Already following other user [visitor's profile]
    if (document.exists) {
      //remove follower
      //remove following

      //1. remove currentUser as a follower from visitorPerson's followersList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userID.value)
          .collection('followers')
          .doc(uidFire)
          .delete();
      //2. remove that visitorProfile's person from the current user's followingList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidFire)
          .collection('following')
          .doc(_userID.value)
          .delete();
      //decrement - update totalFollowers number
      _userMap.value.update('totalFallowers', (value) => (int.parse(value) - 1).toString());
    } else {
      //if currentUser is NOT Already following the other user [visitor's profile]

      //add new follower
      //add new following

      //1. add currentUser as a new follower to visitor's followersList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userID.value)
          .collection('followers')
          .doc(uidFire)
          .set({});
      //2. add that visitProfile person as a new following to the current user's followingList
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidFire)
          .collection('following')
          .doc(_userID.value)
          .set({});
      //increment - update totalFollowers number
      _userMap.value.update('totalFallowers', (value) => (int.parse(value) + 1).toString());
    }
    _userMap.value.update('isFollowing', (value) => !value);

    update();
  }

  getIsFollowingValue() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(_userID.value.toString())
        .collection("followers")
        .doc(uidFire)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowingUser.value = true;
      } else {
        isFollowingUser.value = false;
      }
    });
  }

  void checkUnAndFollowUser() {
    if (userId2 == uidFire) {
      try {
        signOut();
      } catch (e) {
        Get.snackbar('Eroo', '{$e Ocorreu um erro, tente novamente }');
      }
    } else {
      if (isFollowingUser.value == true) {
        isFollowingUser.value = false;
      } else {
        isFollowingUser.value = true;
      }
      followUnFollowUser(); // se deixar aqui vc nao segue a vc mesmo
    }
    // controller.followUnFollowUser(); //com essa função vc segue vc mesmo ao clicar no bot
  }
}
  
// ambos links abaixo inseridos no firebase
//www.youtube.com/ vc manda para pagina do youtube no navegador

//m.youtube.com/  vc manda pro app do youtube no device
// se nao tiver o app no fone ele manda por default no youtube no navegador do device
