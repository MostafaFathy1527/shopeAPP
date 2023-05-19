import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shope/view/widget/custom_text.dart';

import '../core/view_model/auth_view_model.dart';
import 'auth/login_screen.dart';
//mu
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Container(
        padding: EdgeInsets.only(top:100 , left:20, right:20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ) ,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search , color : Colors.black,),
                ) ,
              ),
            ),
            CustomText(
              text:"Categories" ,

            )


          ],
        ),
      ),




    );
  }
}
