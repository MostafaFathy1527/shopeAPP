import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/model/cart_product_model.dart';

import '../services/database/cart_database_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  CartViewModel() {
    getAllProduct();
  }
  getAllProduct() async {
    _loading.value = true;
    _cartProductModel = await CartDatabaseHelper.getAllProduct();
    print(_cartProductModel.length);
    _loading.value = false;
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    _loading.value = true;
    //check for product if it is already in the cart
    final box = await CartDatabaseHelper.getBox();
if (box.containsKey(cartProductModel.productid)) {
      //if product is already in the cart then increase the quantity
      final product = box.get(cartProductModel.productid);
      cartProductModel.quantity = product['quantity'] + 1;

      await box.put(cartProductModel.productid, cartProductModel.toJson());
    } else {
      //if product is not in the cart then add it to the cart
      await box.put(cartProductModel.productid, cartProductModel.toJson());
    }
    update();
  }
}
// Compare this snippet from lib\core\services\database\cart_database_helper.dart: