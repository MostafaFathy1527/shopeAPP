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

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;
  String? name;

  Rx<User?> _user = Rx<User?>(null);

  String? get user => _user.value?.email;
  final LocalStorageDate localStorageDate = Get.find();

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    if (_auth.currentUser != null) {
      getCurrentUserDate(_auth.currentUser!.uid);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      // Sign in to Firebase with the Google credential.
      final UserCredential userCredential =
      await _auth.signInWithCredential(authCredential);

      // Get the user's email address.
      final String? email = userCredential.user!.email;

      // Set the name to be the same as the email address.
      final User? user = _auth.currentUser;
      final displayName = email?.split(
          '@')[0]; // Extract the username part of the email.

      // Update the user's display name.
      await user!.updateDisplayName(displayName);

      Get.offAll(() => ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  void signInWithEmailAndPassword() async {
    if (email == null || password == null) {
      Get.snackbar(
        'Error login account',
        'Please enter email and password',
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (email!.isEmpty || password!.isEmpty) {
      Get.snackbar(
        'Error login account',
        'Please enter email and password',
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      ).then((value) async {
        getCurrentUserDate(value.user!.uid);
      });

      Get.offAll(() => ControlView());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Error login account',
        e.toString(),
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<User?> createAccountWithEmailAndPassword() async {
    if (email == null || password == null) {
      throw Exception('Email or password is null');
    }

    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      await saveUser(userCredential);
      Get.offAll(() => ControlView());
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.to(() => LoginScreen(), preventDuplicates: true);
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveUser(UserCredential user) async {
    UserModel userModel = UserModel(
      userId: user.user!.uid,
      email: user.user!.email,
      name: name == null ? user.user!.email!.split('@')[0] : name,
      pic: '',
    );
    await FireStoreUser().addUserToFireStore(userModel);
    setUser(userModel);
  }

  void setUser(UserModel userModel) async {
    await localStorageDate.setUser(userModel);
  }

  void getCurrentUserDate(String uid) async {
    {
      await FireStoreUser().getCurrentUser(uid).then((value) {
        setUser(UserModel.fromJson(value.data() as Map?));
      });
    }
  }

}