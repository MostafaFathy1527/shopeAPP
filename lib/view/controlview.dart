
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shope/view/home_View.dart';
import 'package:shope/view/profile_view.dart';

import '../constance.dart';
import '../core/view_model/auth_view_model.dart';
import '../core/view_model/control_view_model.dart';
import 'auth/login_screen.dart';
import 'cart_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  Widget currentScreen = CartView();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user==null)
          ? LoginScreen()
          : GetBuilder<ControlViewModel>(
            builder:(controller)=> Scaffold(
              body: controller.currentScreen,
        bottomNavigationBar:bottomNavigationBar(),
      ),
          );
    });
  }


  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) =>
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text("Explore",
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),


                icon: Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Icon(Icons.home,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Text("profile",
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Icon(Icons.person),
                  ),
                  label: ""
              ),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Text("cart",
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Icon(Icons.shopping_cart),
                  ),
                  label: ""
              ),
            ],

            currentIndex: controller.navigatorValue,
            onTap:(index){
              controller.changeSelectedValue(index);
            },
    elevation: 0,
    selectedItemColor: Colors.black,
    backgroundColor: Colors.grey.shade50,
          ),

    );
  }

// Widget bottomNavigationBar() {
  //   return GetBuilder<ControlViewModel>(
  //     init: ControlViewModel(),
  //     builder: (controller) => BottomNavigationBar(
  //       items: [
  //         BottomNavigationBarItem(
  //             activeIcon: Padding(
  //               padding: const EdgeInsets.only(top: 25.0),
  //               child: Text("Explore"),
  //             ),
  //             label: '',
  //             icon: Padding(
  //               padding: const EdgeInsets.only(top: 20),
  //               child: Icon(
  //                 CupertinoIcons.home,
  //                 size: 20,
  //               ),
  //             )),
  //         BottomNavigationBarItem(
  //             activeIcon: Padding(
  //               padding: const EdgeInsets.only(top: 25.0),
  //               child: Text("Profile"),
  //             ),
  //             label: '',
  //             icon: Padding(
  //               padding: const EdgeInsets.only(top: 20),
  //               child: Icon(
  //                 CupertinoIcons.person,
  //                 size: 20,
  //               ),
  //             )),
  //         BottomNavigationBarItem(
  //             activeIcon: Padding(
  //               padding: const EdgeInsets.only(top: 25.0),
  //               child: Text("Cart"),
  //             ),
  //             label: '',
  //             icon: Padding(
  //               padding: const EdgeInsets.only(top: 20),
  //               child: Icon(
  //                 CupertinoIcons.cart,
  //                 size: 20,
  //               ),
  //             )),
  //       ],
  //       currentIndex: controller.navigatorValue,
  //       onTap: (index) {
  //         controller.changeSelectedValue(index);
  //       },
  //       elevation: 0,
  //       selectedItemColor: Colors.black,
  //       backgroundColor: Colors.grey.shade50,
  //     ),
  //   );
  // }
}