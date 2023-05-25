import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shope/model/user_model.dart';

import '../constance.dart';

class LocalStorageDate extends GetxController{
  static setUserData(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userModel.toJson()));
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return UserModel.fromJson(
        json.decode(prefs.getString('user')!) as Map<dynamic, dynamic>);
  }

  static clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}