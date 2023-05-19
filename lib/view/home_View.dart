import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../core/view_model/auth_view_model.dart';
import 'auth/login_screen.dart';

class HomeView extends StatelessWidget {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(
          title: Text('Home'),
    ),
      body: Center(
        child: TextButton(
            child: Text('Log Out'),
            onPressed: () async {
              _auth.signOut();

              Get.off(LoginScreen());
    },

      ),
    )
    );
  }
}
