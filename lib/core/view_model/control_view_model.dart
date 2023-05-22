import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/category_model.dart';
import '../../model/productmodel.dart';
import '../../view/cart_view.dart';
import '../../view/home_View.dart';
import '../../view/profile_view.dart';
import '../services/home_service.dart';
import 'home_view_model.dart';

ControlViewModel controlViewModel = ControlViewModel();

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;

  Widget currentScreen = HomeView();

  @override
  void onClose(){
    super.onClose();
    print('Control deleted from memory');
  }
  void changeSelectedValue(int index) {
    // Update the selected value or perform necessary actions based on the index
    // For example, you can update the value using an Rx variable
    _navigatorValue = index;

    // Or navigate to a different screen based on the index
    if (index == 0) {
      Get.to(HomeView());
    } else if (index == 1) {
      Get.to(ProfileView());
    }
    else if (index == 2) {
      Get.to(CartView());
    }
  }}