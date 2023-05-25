import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/core/view_model/cart_viewmodel.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:shope/model/productmodel.dart';
import 'package:shope/view/widget/CustomButton.dart';
import 'package:shope/view/widget/CustomText2.dart';
import 'package:shope/view/widget/custom_text.dart';
import 'package:sqflite/sqflite.dart';


import '../constance.dart';

class ProductDetailView extends StatelessWidget {
  final ProductModel _productModel;

  ProductDetailView(this._productModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 196,
                        width: double.infinity,
                        child: Image.network(
                          _productModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Column(
                      children: [
                        CustomText2(
                          text: _productModel.name,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedShapeInfo(
                              title: 'Size',
                              content: CustomText2(
                                text: _productModel.size,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                alignment: Alignment.center,
                              ),
                            ),
                            RoundedShapeInfo(
                              title: 'Colour',
                              content: Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        CustomText2(
                          text: 'Details',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: _productModel.descritption,
                          fontSize: 14,
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'PRICE',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      CustomText2(
                        text: '\$${_productModel.price}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                    builder: (controller) => Container(
                      width: 146,
                      child: CustomButton('ADD', () {
                        controller.addProduct(
                          CartProductModel
                          (
                            name: _productModel.name,
                            image: _productModel.image,
                            price: _productModel.price,
                            productid: _productModel.productid,
                            quantity: 1,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedShapeInfo extends StatelessWidget {
  final String title;
  final Widget content;

  const RoundedShapeInfo({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 160,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            content,
          ],
        ),
      ),
    );
  }
}