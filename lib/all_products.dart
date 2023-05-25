import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/core/view_model/home_view_model.dart';
import 'package:shope/view/deatilas_view.dart';

import 'constance.dart';

class AllProducts extends StatelessWidget {
  final HomeViewModel controller = Get.find<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('All Products'),
      ),
      body: GetBuilder<HomeViewModel>(
        init: controller,
        builder: (controller) {
          
          return ListView.builder(
            itemCount: controller.productModel.length,
            itemBuilder: (context, index) {
              final product = controller.productModel[index];
              final price = double.tryParse(product.price) ?? 0.0;

              return ListTile(
                onTap: () {
                  Get.to(ProductDetailView(controller.productModel[index]));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.image),
                ),
                title: Text(product.name),
                subtitle: Text(product.descritption),
                trailing: Text('\$${price.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
