
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../view/home_View.dart';

class AuthViewModel extends GetxController {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String email, password, name;
  Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print(googleUser);
    GoogleSignInAuthentication? googleSignInAuthentication =
    await googleUser?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );
    print(credential);
  }



  void googleSignOutMethod() async {
    await _googleSignIn.signOut();
  }
  // void signInWithEmailAndPassword() async {
  //   try {
  //     await _auth
  //         .signInWithEmailAndPassword(email: email, password: password)
  //         .then((user) async {
  //       saveUser(user);
  //     });
  //
  //     Get.offAll(HomeView());
  //   } catch (e) {
  //     print(e.message);
  //     Get.snackbar(
  //       'Error login account',
  //       e.message,
  //       colorText: Colors.black,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
  // void createAccountWithEmailAndPassword() async {
  //   try {
  //     await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password)
  //         .then((user) async {
  //       saveUser(user);
  //     });
  //
  //     Get.offAll(HomeView());
  //   } catch (e) {
  //     print(e.message);
  //     Get.snackbar(
  //       'Error login account',
  //       e.message,
  //       colorText: Colors.black,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }


}