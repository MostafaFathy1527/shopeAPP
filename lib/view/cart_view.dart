import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shope/constance.dart';
import 'package:shope/view/widget/custom_text.dart';

class CartView extends StatelessWidget {

  List<String> names = <String>[
    'item1',
    'item2',
    'item3',
    'item4',
    'item5',
  ];
  List<String> images = <String>[
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
    'assets/images/google.png',
  ];
  List<String> prices = <String>[
    '\$1',
    '\$1',
    '\$1',
    '\$1',
    '\$1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(

                    height: 140,
                    child: Row(
                      children: [
                        Image.asset(images[index],
                          fit: BoxFit.fill,
                          width: 70,
                          height: 70,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: names[index],
                          fontSize: 24,
                        ),
                        SizedBox(height: 10,),
                        CustomText(
                          text: '\$${prices[index]}',
                        ),
                        SizedBox(height: 30,),
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
                              SizedBox(height: 30,),
                              CustomText(
                                text: '1',
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 30,),
                              //the icon is not centered
                              Container(
                                alignment:Alignment.topCenter,
                                  child: Icon(Icons.minimize)),
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
                itemCount: names.length, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 40,);

    },
            ),

    ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // total price and checkout button
              children: [
                Column(
                  children: [
                    SizedBox(height: 20,),

                    CustomText(text: 'TOTAL', fontSize: 22, color: Colors.grey,),
                    SizedBox(height: 5,),
                    CustomText(text: '\$2000', fontSize: 18, color: primaryColor,),
                  ],

                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                  ),
                  child:
                  TextButton(
                    onPressed: (){},
                    child: CustomText(text: 'CHECKOUT', fontSize: 22, color: Colors.white,),
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                    ),
                  ),
                )
 ],

            ),
          ),
          SizedBox(height: 20,),
        ],

      ),
    );
  }
}
