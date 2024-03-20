import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/app/models/user_model.dart';

class SearchController2 extends GetxController {
  final Rx<List<UserModel>> _userSearchList = Rx<List<UserModel>>([]);

  List<UserModel> get userSearchList => _userSearchList.value;

  searchForUser(String textInput) async {
    _userSearchList.bindStream(
      FirebaseFirestore.instance.collection('users').where('name', isGreaterThanOrEqualTo: textInput).snapshots().map(
        (QuerySnapshot searcheUserQuerySnapshot) {
          List<UserModel> searchList = [];

          for (var user in searcheUserQuerySnapshot.docs) {
            searchList.add(UserModel.fromSnap(user));
          }

          return searchList;
        },
      ),
    );
  }
}
