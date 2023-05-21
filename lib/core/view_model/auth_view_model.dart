import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope/core/view_model/control_view_model.dart';
import 'package:shope/view/auth/login_screen.dart';

import '../../model/user_model.dart';
import '../../service/firestore_user.dart';
import '../../view/home_View.dart';

class AuthViewModel extends GetxController {


  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  FirebaseAuth _auth = FirebaseAuth.instance;

   String? email;
   String? password;
   String? name;

  Rxn<User> _user = Rxn<User>();


  String? get user => _user.value?.email;


  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
    _loadbottom();
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
    _loadbottom();

  }

  void googleSignInMethod() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print(googleUser);
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,

    );

    await _auth.signInWithCredential(credential).then((user) {


      Get.offAll(() => HomeView());
      _loadbottom();
    });
  }

  void signInWithEmailAndPassword() async {
    if (email == null || password == null) {
      // Handle nullability
      Get.snackbar(
        'Error login account',
        'Please enter email and password',
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (email!.isEmpty || password!.isEmpty) {
      // Check if both email and password are empty
      Get.snackbar(
        'Error login account',
        'Please enter email and password',
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await _auth.signInWithEmailAndPassword(email: email!, password: password!);
      Get.offAll(() => HomeView()
      );
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
    print('email: $email, password: $password');
    if (email == null || password == null) {
      throw Exception('Email or password is null');
    }

    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email!, password: password!);
      await saveUser(userCredential);
      Get.offAll(() => HomeView());
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


  // Sign out method
  void signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      await _googleSignIn.signOut();
      await _auth.signOut();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveUser(UserCredential user) async {
    await FireStoreUser().addUserToFireStore(UserModel(
      userId: user.user?.uid,
      email: user.user?.email,
      name: name == null ? user.user?.displayName : name,
      pic: '',
    ));
  }
  Widget _loadbottom(){
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => Text(""),
    );
  }
}