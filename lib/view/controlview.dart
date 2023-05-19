import 'package:get/get.dart';
import 'package:shope/core/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';
import 'home_View.dart';


class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(Get.find<AuthViewModel>().user);
      print('user');
      return (Get.find<AuthViewModel>().user == null) ? LoginScreen() : HomeView();
    });
  }
}
