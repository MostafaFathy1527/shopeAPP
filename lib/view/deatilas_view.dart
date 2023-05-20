import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shope/model/productmodel.dart';
import 'package:shope/view/widget/custom_text.dart';

import '../constance.dart';

class DeatilasView extends StatelessWidget {
  ProductModel model;
  DeatilasView({required this.model});
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 270,
              child: Image.network(
                model.image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(18),
                  child: Column(
                    children: [
                      CustomText(
                        text: model.name,
                        fontSize: 26,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * .4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomText(
                                  text: 'Size',
                                ),
                                CustomText(
                                  text: model.size,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width * .44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomText(
                                  text: 'Color',
                                ),
                                Container(
                                  width: 30,
                                  height: 20,
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( model.color == 'red')? Colors.red:Colors.blue,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: 'Details',
                        fontSize: 18,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: model.descritption,
                        fontSize: 18,
                        height: 2.5,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(
                        text: "PRICE ",
                        fontSize: 22,
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: ' \$' + model.price,
                        color: primaryColor,
                        fontSize: 18,
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: primaryColor,
                    ),

                    padding: EdgeInsets.all(20),
                    width: 180,
                    height: 100,
                    child: Center(
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                        ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
