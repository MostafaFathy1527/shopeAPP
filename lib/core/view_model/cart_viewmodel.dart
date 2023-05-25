import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database/cart_database_helper.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;
  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;
  bool isCartEmpty = false ;

  CartViewModel() {
    getAllProduct();
  }
  getAllProduct() async {
    _loading.value = true;
    _cartProductModel = await CartDatabaseHelper.getAllProduct();
    print(_cartProductModel.length);
    _loading.value = false;
    getTotlaPrice();
    update();
  }
  getTotlaPrice() {
    for(int i=0; i<_cartProductModel.length;i++){
      _totalPrice += double.parse(_cartProductModel[i].price) * _cartProductModel[i].quantity;
      print('you have to pay $_totalPrice');
      update();
    }
  }

  addProduct(CartProductModel cartProductModel) async {
    _loading.value = true;
    //check for product if it is already in the cart
    final box = await CartDatabaseHelper.getBox();
if (box.containsKey(cartProductModel.productid)) {

      //if product is already in the cart then increase the quantity
      final product = box.get(cartProductModel.productid);
      cartProductModel.quantity = product['quantity'] + 1;
      print(cartProductModel.quantity);
      await box.put(cartProductModel.productid, cartProductModel.toJson());
    } else {
      //if product is not in the cart then add it to the cart
      await box.put(cartProductModel.productid, cartProductModel.toJson());

    }
    _totalPrice += double.parse(cartProductModel.price) * cartProductModel.quantity;
    print('you have to pay $_totalPrice');
    update();
  }
  increaseQuantity(CartProductModel cartProductModel) async {
    _loading.value = true;
    final box = await CartDatabaseHelper.getBox();
    final product = box.get(cartProductModel.productid);
    cartProductModel.quantity = product['quantity'] + 1;
    await box.put(cartProductModel.productid, cartProductModel.toJson());
    _totalPrice += double.parse(cartProductModel.price);
    print('you have to pay $_totalPrice');
    update();
  }
  decreaseQuantity(CartProductModel cartProductModel) async {
    _loading.value = true;
    final box = await CartDatabaseHelper.getBox();
    final product = box.get(cartProductModel.productid);
    if(product['quantity'] == 0){
      return;
    }
    if(product['quantity'] == 1) {
      await box.delete(cartProductModel.productid);
      _cartProductModel.removeWhere((element) =>
      element.productid == cartProductModel.productid);
    }else{
      cartProductModel.quantity = product['quantity'] - 1;
      await box.put(cartProductModel.productid, cartProductModel.toJson());
    }
    _totalPrice -= double.parse(cartProductModel.price);
    print('you have to pay $_totalPrice');
    update();
  }
 Future< void> clearCart() async {
    // Clear the cart items from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');

    // Clear the cartProductModel list in-memory
    cartProductModel.clear();
    _totalPrice = 0.0;
    isCartEmpty = true;
    update();
  }
  Future<void> saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map> cartItems = cartProductModel
        .map((product) => product.toJson())
        .toList();

    await prefs.setString('cartItems', jsonEncode(cartItems));
  }
  void loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartItemsJson = prefs.getString('cartItems');

    if (cartItemsJson != null) {
      // Convert the cart items from JSON to List<CartProductModel>
      List<dynamic> cartItemsData = jsonDecode(cartItemsJson);
      List<CartProductModel> loadedCartItems = cartItemsData
          .map((item) => CartProductModel.fromJson(item))
          .toList();

      // Update the cartProductModel with the loaded items
      _cartProductModel = loadedCartItems;
    }
  }




}
// Compare this snippet from lib\core\services\database\cart_database_helper.dart: