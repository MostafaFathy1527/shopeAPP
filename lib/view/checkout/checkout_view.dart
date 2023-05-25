import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:shope/view/controlview.dart';
import 'package:shope/view/widget/custom_text.dart';

import '../../constance.dart';
import '../../core/view_model/cart_viewmodel.dart';

class CheckoutView extends StatefulWidget {
  final List<CartProductModel> cartProducts;

  CheckoutView({required this.cartProducts});

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedPaymentMethod = '';

  TextEditingController shippingAddressController = TextEditingController();

  @override
  void dispose() {
    shippingAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Shipping Address',
                fontSize: 18,
              ),
              SizedBox(height: 10),
              TextField(
                controller: shippingAddressController,
                decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              CustomText(
                text: 'Payment Method',
                fontSize: 18,
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  final paymentMethod = paymentMethods[index];
                  return RadioListTile(
                    title: Text(paymentMethod),
                    value: paymentMethod,
                    groupValue: selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        selectedPaymentMethod = value.toString();
                      });
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              CustomText(
                text: 'Order Summary',
                fontSize: 18,
              ),
              SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                itemCount: widget.cartProducts.length,
                itemBuilder: (context, index) {
                  final product = widget.cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: product.name,
                          fontSize: 16,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: 'x${product.quantity.toString()}',
                              fontSize: 16,
                            ),
                            SizedBox(width: 10),
                            CustomText(
                              text: '\$${product.price}',
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Total',
                    fontSize: 18,
                  ),
                  GetBuilder<CartViewModel>(
                    init: Get.find(),
                    builder: (controller) => CustomText(
                      text: '\$ ${controller.totalPrice}',
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    // Place order logic
                    String address = shippingAddressController.text;
                    if (address.isNotEmpty) {

                      Get.snackbar(

                        'Order Placed', 'Your order has been placed successfully.'
                          '\nThank you for shopping with us.'
                          '\nYour order will be delivered to $address.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                        duration: Duration(seconds: 7),
                      );

                      // Clear the cart
                      await Get.find<CartViewModel>().clearCart();
                      Get.find<CartViewModel>().isCartEmpty = true;
                      // Save the cart items to local storage
                      await Get.find<CartViewModel>().saveCartItems();

                      // Navigate to home screen
                      Get.offAll(ControlView());

                    } else {
                      Get.snackbar('Error', 'Please enter a shipping address.');
                    }
                  },
                  child: Text('Place Order'),
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> paymentMethods = [
    'Credit Card',
    'PayPal',
    'Google Pay',
    'Apple Pay',
    'Bank Transfer',
  ];
}
