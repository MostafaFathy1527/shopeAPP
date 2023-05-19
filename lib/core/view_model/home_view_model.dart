import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/category_model.dart';
import '../../model/productmodel.dart';
import '../services/home_service.dart';

class HomeViewModel extends GetxController {
  // ValueNotifier<bool> get loading => _loading;
  // ValueNotifier<bool> _loading = ValueNotifier(false);
  //
  // List<CategoryModel> get categoryModel => _categoryModel;
  // List<CategoryModel> _categoryModel = [];
  //
  // List<ProductModel> get productModel => _productModel;
  // List<ProductModel> _productModel = [];
  // HomeViewModel homeViewModel = Get.put(HomeViewModel());
  //
  // HomeViewModel() {
  //   getCategory();
  //   getBestSellingProducts();
  // }
  //
  // getCategory() async {
  //   _loading.value = true;
  //   HomeService()
  //       .getCategory()
  //       .then((value) {
  //     for (int i = 0; i < value.length; i++) {
  //       var data = value[i].data();
  //       if(data is Map<String, dynamic>) {
  //         _categoryModel.add(CategoryModel.fromJson(data));
  //       }
  //     }
  //     _loading.value = false;
  //     update();
  //   });
  // }
  //
  // getBestSellingProducts() async {
  //   _loading.value = true;
  //   HomeService()
  //       .getBestSelling()
  //       .then((value) {
  //     for (int i = 0; i < value.length; i++) {
  //       var data = value[i].data();
  //       if(data is Map<String, dynamic>) {
  //         _productModel.add(ProductModel.fromJson(data));
  //       }
  //     }
  //     _loading.value = false;
  //     update();
  //   });
  // }
  int _navigatorValue = 0;
  int get navigatorValue => _navigatorValue;
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    update();
  }
}