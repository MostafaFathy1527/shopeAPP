import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shope/constance.dart';
import 'package:shope/core/view_model/control_view_model.dart';
import 'package:shope/core/view_model/home_view_model.dart';
import 'package:shope/view/widget/custom_text.dart';

import '../core/view_model/auth_view_model.dart';
import 'auth/login_screen.dart';
//mu
class HomeView extends StatelessWidget {
  final List<String>  names = <String>[
    '1',
    '1',
    '1',
    '1',
    '1',
  ];
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<HomeViewModel>(
      builder:(controller)=> Scaffold(
        body:  SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top:100 , left:20, right:20),
            child: Column(
              children: [
                _searchTextFormField(),


                SizedBox(height: 50,),
                _listViewCategory(),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Best Selling",
                      fontSize: 18,
                    ),
                    CustomText(
                      text: "See all",
                      fontSize: 16,
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                _listViewProducts(),
              ],
            ),
          ),
        ),


      ),
    );
  }
 Widget _listViewCategory(){

   return  Column(
      children: [
        CustomText(
          text:"Categories" ,
          fontSize: 24,
        ),


        SizedBox(height: 30,),


        Container(
          height: 100,
          child: ListView.separated(
            itemCount: names.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context , index){
              return Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey.shade200,
                      ) ,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.asset("assets/images/google.png" ,
                          width: 40,
                          height:   40,
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    CustomText(
                      text: names[index],
                      alignment: Alignment.bottomCenter,
                    )
                  ],
                ),
              );

            }, separatorBuilder: ( context, index)=>SizedBox(
            width: 20,
          ) ,
          ),
        ),
      ],
    );
  }
  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade100,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          hintText: "Search",
        ),
      ),
    );
  }
  Widget _listViewProducts() {
    return Container(
      height: 350,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context , index){
          return Container(
            width: MediaQuery.of(context).size.width * .4,
            child: Column(
                children:[
                  Container(
                    width: MediaQuery.of(context).size.width * .4,
                    decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100,
                ) ,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child:
                  Image.asset(
                    "assets/images/watch.png",
                   fit: BoxFit.fill,
                   height:   220,
                  ),

                ),
              ),
                  SizedBox(height: 20,),

                  CustomText(

                text: "dsadasdasdwatch",
                alignment: Alignment.bottomCenter,
              ),
              CustomText(
                text: "watch",
                alignment: Alignment.bottomLeft,
                color: Colors.grey,
              ),
              CustomText(
                text: "10\$",
                alignment: Alignment.bottomLeft,
                color: primaryColor,
              ),
              ]
            ),
          );

        }, separatorBuilder: ( context, index)=>SizedBox(
        width: 20,
      ) ,
      ),
    );
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
        onTap: (index)=>controller.changeSelectedValue(index),
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        selectedItemColor: primaryColor,
       ),
      );
  }
}

