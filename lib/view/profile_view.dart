import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/view_model/auth_view_model.dart';

class ProfileView extends StatelessWidget {

  AuthViewModel authViewModel = Get.find();
  @override
  Widget build(BuildContext context) {

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
            name!,
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
    );
  }
}

