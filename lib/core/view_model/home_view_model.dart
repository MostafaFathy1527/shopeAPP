import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shope/core/services/home_service.dart';

import '../../model/category_model.dart';
import '../../model/productmodel.dart';
import 'control_view_model.dart';
HomeViewModel homeViewModel = HomeViewModel();

class HomeViewModel extends GetxController{
  ValueNotifier<bool>  get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  List <CategoryModel> get categoryModel => _categoryModel;
  List <CategoryModel> _categoryModel = [];

  List <ProductModel> get productModel => _productModel;
  List <ProductModel> _productModel = [];




HomeViewModel(){
  getCategory();
  getBestSelling();
}

@override
void onInit(){
  super.onInit();
  init: ControlViewModel();
}
  @override
  void onClose(){
    super.onClose();
    print('HomeViewModel deleted from memory');
  }

  getCategory() async {
  _loading.value = true;
  HomeService().getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categoryModel.add(CategoryModel.fromJson(
            value[i].data() as Map<String, dynamic>
        ));
        update();
        _loading.value = false;

      }

     });

  }
  getBestSelling() async{
    _loading.value = true;
    HomeService().getBestSelling().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModel.add(ProductModel.fromJson(
            value[i].data() as Map<String, dynamic>
        ));
        print("productsssssssssss") ;
        print(_productModel[i].name);
        update();
        _loading.value = false;
      }

    });
  }

}