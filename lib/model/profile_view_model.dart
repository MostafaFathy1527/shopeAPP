import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shope/helper/local_storage_data.dart';
import 'package:shope/model/user_model.dart';

class ProfileViewModel extends GetxController {
  @override
  onInit() {
    super.onInit();

    getCurrentUser();
  }
  final LocalStorageDate localStorageDate = Get.find();
  UserModel get userModel => _userModel;
    late  UserModel _userModel;

  Future<void> signOut() async {
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    localStorageDate.deleteUser();

  }

  void getCurrentUser() async {
    await localStorageDate.getUser.then((value) {
      _userModel = value!;
      update();
    });
    update();
  }
}