import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shope/core/services/database/cart_database_helper.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/cart_product_model.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading=> _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List<cartProductModel> cartProductModelList = [];

  CartViewModel() {
    getAllProducts();
  }
  getAllProducts() async {
    _loading.value = true;
    var dbHelper = CartDatabaseHelper.db;
    var cartProductModelList = await dbHelper.getAllProduct();
    print(cartProductModelList.length);
    _loading.value = false;
  }
  addProduct(cartProductModel cartProductModel)async{
    var dbHelper = CartDatabaseHelper.db;
    await dbHelper.insert(cartProductModel);
    update();
  }
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    update();
  }
}