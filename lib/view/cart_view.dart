  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_svg/flutter_svg.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_state_manager/src/simple/get_state.dart';
  import 'package:shope/constance.dart';
  import 'package:shope/core/view_model/cart_viewmodel.dart';
  import 'package:shope/model/cart_product_model.dart';
import 'package:shope/view/widget/CustomButton.dart';
import 'package:shope/view/widget/CustomText2.dart';
  import 'package:shope/view/widget/custom_text.dart';
  import '../core/view_model/control_view_model.dart';
  import 'checkout/checkout_view.dart';

  class CartView extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: GetBuilder<CartViewModel>(
          builder: (controller) => controller.cartProductModel.isEmpty
              ?
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SvgPicture.asset('assets/images/undraw_empty_cart_co35.svg',width: 200,height: 200,),
                SizedBox(height: 20,),
                Text('Cart Empty ',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),
              ],
            ),
          )
              : Column(
            children: [
              Expanded(
                child: Padding(
                  padding:
                  EdgeInsets.only(top: 74, right: 16, left: 16),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(controller.cartProductModel[index].productid),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 33),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            controller.removeProduct(
                                controller.cartProductModel[index]);
                          }
                        },
                        child: Row(
                          children: [
                            Image.network(
                              controller.cartProductModel[index].image,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: controller.cartProductModel[index].name,
                                  fontSize: 16,
                                ),
                                CustomText(
                                  text:
                                  '\$${controller.cartProductModel[index].price}',
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 30,
                                  width: 95,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(4),
                                    color: Colors.grey.shade300,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          child: Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          onTap: () {
                                            controller.increaseQuantity(controller.cartProductModel[index]);

                                          },
                                        ),
                                        CustomText(
                                          text: controller
                                              .cartProductModel[index]
                                              .quantity
                                              .toString(),
                                          fontSize: 16,
                                          alignment: Alignment.center,
                                        ),
                                        GestureDetector(
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                          ),
                                            onTap: (){
                                controller.decreaseQuantity(controller.cartProductModel[index]);
                                },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: 16,
                    ),
                    itemCount: controller.cartProductModel.length,
                  ),
                ),
              ),
              Material(
                elevation: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 30, vertical: 17),
                  height: 84,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'TOTAL',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          CustomText2(
                            text: '\$${controller.totalPrice.toString()}',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      Container(
                        height: 50,
                        width: 146,
                        child: CustomButton(
                          'CHECKOUT',
                              () {
                            Get.to(CheckoutView());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),        bottomNavigationBar: bottomNavigationBar(),
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
  }
