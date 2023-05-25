import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/model/profile_view_model.dart';
import 'package:shope/view/auth/login_screen.dart';
import 'package:shope/view/widget/CustomText2.dart';

import '../constance.dart';
import '../core/view_model/auth_view_model.dart';
import '../core/view_model/control_view_model.dart';
import 'package:flutter/painting.dart'; // For NetworkImage
import 'package:flutter/widgets.dart';

import 'cards_view.dart';
import 'edit_profile_view.dart';
import 'notifications_view.dart';
import 'order_history_view.dart'; // For AssetImage

class ProfileView extends StatelessWidget {
  AuthViewModel authViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Trigger hot reload after the first frame is displayed
      hotReload();
    });

    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        body: GetBuilder<ProfileViewModel>(
          init: ProfileViewModel(),
          builder: (controller) => controller.loading == true
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 58, right: 16, left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        foregroundImage:
                        controller.currentUser!.pic != 'default'
                            ? NetworkImage(controller.currentUser!.pic!)
                            : null,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Column(
                        children: [
                          CustomText2(
                            text: controller.currentUser!.name!,
                            fontSize: 26,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          CustomText2(
                            text: controller.currentUser!.email!,
                            fontSize: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit Profile'),
                    onTap: () {
                      Get.to(EditProfileView());
                    },
                  ),

                  // Shipping address

                  // Order history
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Order History'),
                    onTap: () {
                      Get.to(OrderHistoryView());
                    },
                  ),

                  // Cards
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Cards'),
                    onTap: () {
                      Get.to(CardsView());
                    },
                  ),

                  // Notifications
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('Notifications'),
                    onTap: () {
                      Get.to(NotificationsView());
                    },
                  ),

                  CustomListTile(
                    iconName: '6',
                    title: 'Log Out',
                    onTapFn: () {
                      Get.find<AuthViewModel>().signOut();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Explore",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.home),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Profile",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.person),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Cart",
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(Icons.shopping_cart),
            ),
            label: "",
          ),
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        elevation: 0,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.grey.shade50,
      ),
    );
  }

  void hotReload() {
    Get.find<ControlViewModel>().update();
  }

}
class CustomListTile extends StatelessWidget {
  final String iconName;
  final String title;
  final VoidCallback onTapFn;

  const CustomListTile({
    required this.iconName,
    required this.title,
    required this.onTapFn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTapFn,
          leading: Icon(Icons.exit_to_app),
          title: CustomText2(
            text: title,
            fontSize: 18,
          ),
          trailing: title == 'Log Out'
              ? null
              : Icon(
            Icons.navigate_next,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

