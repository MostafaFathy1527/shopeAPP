import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constance.dart';
import '../core/view_model/auth_view_model.dart';
import '../core/view_model/control_view_model.dart';

class ProfileView extends StatelessWidget {

  AuthViewModel authViewModel = Get.find();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Trigger hot reload after the first frame is displayed
      hotReload();
    });

    var name = authViewModel.user;

    return Scaffold(
      body: Column(
          children: [
SizedBox(
        height: 70,
),
      // Avatar and name
      Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://storage.googleapis.com/shope-2c566.appspot.com/1.jpg'),
            radius: 30,
          ),
          SizedBox(width: 20),
          Text(
            name?? 'User Name',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    ),

          // Edit profile
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Edit Profile'),
            onTap: () {
              // Navigate to EditProfile page
            },
          ),

          // Shipping address
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Shipping Address'),
            onTap: () {

            },
          ),

          // Order history
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Order History'),
            onTap: () {

            },
          ),

          // Cards
          ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Cards'),
              onTap: () { }
          ),

          // Notifications
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
            },
          ),

          // Logout
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              authViewModel.signOut();
            },
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }
  Widget bottomNavigationBar() {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(), // Initialize the ControlViewModel
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

