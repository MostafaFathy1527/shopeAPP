import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope/core/view_model/control_view_model.dart';
import 'package:shope/view/auth/login_screen.dart';
import 'package:shope/view/controlview.dart';

import '../../constance.dart';
import '../../helper/local_storage_data.dart';
import '../../model/user_model.dart';
import '../../view/home_View.dart';
import '../services/firestore_user.dart';
import 'package:http/http.dart' as http;

class AuthViewModel extends GetxController {
  String? email, password, name;

  Rxn<User>? _user = Rxn<User>();

  String? get user => _user?.value?.email;

  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    _user!.bindStream(_auth.authStateChanges());
  }


  void signUpWithEmailAndPassword() async {
    try {
      final url = 'https://us-central1-shope-2c566.cloudfunctions.net/signup'; // Replace with the actual Cloud Function URL
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        saveUserLocal(UserModel(userId: data['userId'], email: email, name: name, pic: 'default'));

        Get.offAll(ControlView());
      } else {
        final errorMessage = json.decode(response.body)['message'];
        Get.snackbar(
          'Failed to signup..',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Failed to signup..',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
}

  void signInWithEmailAndPassword() async {
    try {
      final url = 'https://us-central1-shope-2c566.cloudfunctions.net/login'; // Replace with the actual Cloud Function URL
      final response = await http.post(
        Uri.parse(url),
        body: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        saveUserLocal(UserModel(userId: data['userId'], email: email, name: name, pic: 'default'));
        Get.offAll(ControlView());
      } else {
        final errorMessage = json.decode(response.body)['message'];
        Get.snackbar(
          'Failed to login..',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Failed to login..',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try {
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);
      saveUser(userCredential);
      Get.offAll(ControlView());
    } catch (error) {
      Get.snackbar(
        'Failed to login..',
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  void signOut() async {
    try {
      await _auth.signOut();
      
      Get.offAll(LoginScreen());
      LocalStorageDate.clearUserData();
    } catch (error) {
      print(error);
    }
  }

  void saveUser(UserCredential userCredential) async {
    UserModel _userModel = UserModel(
      userId: userCredential.user!.uid,
      email: userCredential.user!.email!,
      name: name == null ? userCredential.user!.displayName! : this.name!,
      pic: userCredential.user!.photoURL == null
          ? 'default'
          : userCredential.user!.photoURL! + "?width=400",
    );
    FireStoreUser().addUserToFirestore(_userModel);
    saveUserLocal(_userModel);
  }

  void saveUserLocal(UserModel userModel) async {
    LocalStorageDate.setUserData(userModel);
  }
}
