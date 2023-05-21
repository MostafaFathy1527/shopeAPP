import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shope/constance.dart';
import 'package:shope/core/view_model/control_view_model.dart';
import 'package:shope/core/view_model/home_view_model.dart';
import 'package:shope/view/cart_view.dart';
import 'package:shope/view/deatilas_view.dart';
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
    init: HomeViewModel(),

        builder:(controller)=>controller.loading.value? Center(child: CircularProgressIndicator()) :
      Scaffold(
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

    return  GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder:(controller)=> Column(

        children: [
          CustomText(
            text:"Categories" ,
            fontSize: 24,
          ),


          SizedBox(height: 30,),

          Container(
            height: 100,
            child: ListView.separated(

              itemCount: controller.categoryModel.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context , index){

                return Container(
                  width: MediaQuery.of(context).size.width * .25,
                  child: Column(
                    children: [

                      SizedBox(height: 20,),
                      CustomText(
                        text: controller.categoryModel[index].name,
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
      ),
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
    return GetBuilder<HomeViewModel>(
      builder:(controller)=>Container(
        height: 500,
        child: ListView.separated(
          itemCount: controller.productModel.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context , index){
            return GestureDetector(
              onTap: (){
                Get.to(DeatilasView(model: controller.productModel[index],));
              },

              child: Container(
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
                          Image.network(controller.productModel[index].image,
                            fit: BoxFit.fill,
                            height:   220,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),

                      CustomText(

                        text: controller.productModel[index].name,
                        alignment: Alignment.bottomCenter,
                      ),
                        CustomText(
                        text: controller.productModel[index].descritption,
                        alignment: Alignment.bottomLeft,
                        color: Colors.grey,

                      ),
                      CustomText(
                        text: controller.productModel[index].price.toString() ,
                        alignment: Alignment.bottomLeft,
                        color: primaryColor,
                      ),

                    ]
                ),

              ),
            );

          },
          separatorBuilder: ( context, index)=>SizedBox(
            width: 20,
          ) ,

        ),

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
            onTap:(index){
              if(index==1){
                Get.to(CartView());
              }
            },
            elevation: 0,
            backgroundColor: Colors.grey.shade50,
            selectedItemColor: primaryColor,
          ),
    );
  }

}
