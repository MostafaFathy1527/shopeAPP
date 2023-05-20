import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

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
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = HomeView();
          break;
        }
      case 1:
        {
          currentScreen = ProfileView();
          break;
        }
      case 2:
        {
          currentScreen = CartView();
          break;
        }
    }
    update();
  }
}