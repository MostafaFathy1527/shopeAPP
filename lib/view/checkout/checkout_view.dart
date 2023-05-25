import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:shope/view/controlview.dart';
import 'package:shope/view/widget/CustomText2.dart';
import 'package:shope/view/widget/custom_text.dart';

import '../../constance.dart';
import '../../core/view_model/cart_viewmodel.dart';
import '../../model/checkout_viewmodel.dart';
import '../widget/CustomButton.dart';
import '../widget/custom_textFormField2.dart';

class CheckoutView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                  CustomText(
                    text: 'Checkout',
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
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 24),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<CheckoutViewModel>(
                    init: Get.find<CheckoutViewModel>(),
                    builder: (controller) => Column(
                      children: [
                        ListViewProducts(),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField2(
                          title: 'Street',
                          hintText: '518 asafra',
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'Please enter valid street name.';
                          },
                          onSavedFn: (value) {
                            controller.street = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField2(
                          title: 'City',
                          hintText: ' Alexandria',
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 4)
                              return 'Please enter valid city name.';
                          },
                          onSavedFn: (value) {
                            controller.city = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField2(
                                title: 'State',
                                hintText: 'Alexandria',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 4)
                                    return 'Please enter valid state name.';
                                },
                                onSavedFn: (value) {
                                  controller.state = value;
                                },
                              ),
                            ),
                            SizedBox(
                              width: 36,
                            ),
                            Expanded(
                              child: CustomTextFormField2(
                                title: 'Country',
                                hintText: 'Egypt',
                                validatorFn: (value) {
                                  if (value!.isEmpty || value.length < 4)
                                    return 'Please enter valid city name.';
                                },
                                onSavedFn: (value) {
                                  controller.country = value;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField2(
                          title: 'Phone Number',
                          hintText: '+201017230938',
                          keyboardType: TextInputType.phone,
                          validatorFn: (value) {
                            if (value!.isEmpty || value.length < 10)
                              return 'Please enter valid number.';
                          },
                          onSavedFn: (value) {
                            controller.phone = value;
                          },
                        ),
                        SizedBox(
                          height: 38,
                        ),
                        CustomButton(
                          'SUBMIT',
                              () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await controller.addCheckoutToFireStore();
                              Get.dialog(
                                AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: primaryColor,
                                          size: 200,
                                        ),
                                        CustomText2(
                                          text: 'Order Submitted',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor,
                                          alignment: Alignment.center,
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        CustomButton(
                                          'Done',
                                              () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListViewProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
      builder: (controller) => Column(
        children: [
          Container(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.cartProductModel.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white,
                        ),
                        height: 120,
                        width: 120,
                        child: Image.network(
                          controller.cartProductModel[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomText2(
                        text: controller.cartProductModel[index].name,
                        fontSize: 14,
                        maxLines: 1,
                      ),
                      CustomText(
                        text:
                        '\$${controller.cartProductModel[index].price} x ${controller.cartProductModel[index].quantity}',
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: 15,
                );
              },
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'TOTAL: ',
                fontSize: 14,
                color: Colors.grey,
              ),
              CustomText2(
                text: '\$${controller.totalPrice.toString()}',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
