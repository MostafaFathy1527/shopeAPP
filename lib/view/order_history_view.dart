import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shope/view/widget/CustomText2.dart';

import '../constance.dart';
import '../model/checkout_viewmodel.dart';

class OrderHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 130,
            child: Padding(
              padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  CustomText2(
                    text: 'Order History',
                    fontSize: 20,
                    alignment: Alignment.bottomCenter,
                  ),
                  Container(
                    width: 24,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GetBuilder<CheckoutViewModel>(
              init: Get.find<CheckoutViewModel>(),
              builder: (controller) => ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText2(
                                    text: controller.checkouts[index].date,
                                    color: Colors.grey,
                                  ),
                                  CustomText2(
                                    text: 'Pending',
                                    color: Colors.red.shade300,
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              ),
                              CustomText2(
                                text: controller.checkouts[index].street,
                              ),
                              CustomText2(
                                text: controller.checkouts[index].city,
                              ),
                              CustomText2(
                                text: controller.checkouts[index].state,
                              ),
                              CustomText2(
                                text: controller.checkouts[index].country,
                              ),
                              CustomText2(
                                text: controller.checkouts[index].phone,
                              ),
                              Divider(
                                thickness: 1,
                                color: Colors.grey.shade200,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText2(
                                    text: 'Total Billed',
                                    color: primaryColor,
                                  ),
                                  CustomText2(
                                    text:
                                    '\$${controller.checkouts[index].totalPrice}',
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                  color: Colors.grey.shade200,
                ),
                itemCount: controller.checkouts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
