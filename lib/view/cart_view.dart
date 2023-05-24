import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shope/constance.dart';
import 'package:shope/core/view_model/cart_viewmodel.dart';
import 'package:shope/view/widget/custom_text.dart';
import '../core/view_model/control_view_model.dart';

class CartView extends StatelessWidget {
  final List<String> names = <String>[
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];
  final List<String> images = <String>[
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
  ];
  final List<String> prices = <String>[
    '\$1',
    '\$1',
    '\$1',
    '\$1',
    '\$1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Expanded(
            child: GetBuilder<CartViewModel>(
              init: CartViewModel(),
              builder: (controller) => Container(
                child: ListView.separated(
                  itemBuilder:(context, index) {
                    return Container(
                      height: 140,
                      child: Row(
                        children: [
                          Image.network(
                            controller.cartProductModel[index].image,
                            fit: BoxFit.fill,
                            width: 70,
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    controller.cartProductModel[index].name,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 10),
                                CustomText(
                                  text: '\$${controller.cartProductModel[index].price.toString()}',
                                ),
                                SizedBox(height: 30),
                                Container(
                                  width: 140,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.add),
                                      SizedBox(height: 30),
                                      CustomText(
                                        text: '1',
                                        alignment: Alignment.center,
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                        alignment: Alignment.topCenter,
                                        child: Icon(Icons.minimize),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.cartProductModel.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 40);
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    CustomText(text: 'TOTAL', fontSize: 22, color: Colors.grey),
                    SizedBox(height: 5),
                    CustomText(text: '\$2000', fontSize: 18, color: primaryColor),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: CustomText(text: 'CHECKOUT', fontSize: 22, color: Colors.white),
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(),
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
