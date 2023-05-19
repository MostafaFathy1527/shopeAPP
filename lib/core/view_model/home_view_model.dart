import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/category_model.dart';

class HomeViewModel extends GetxController{
  List <CategoryModel> get categoryModel => _categoryModel;
  List <CategoryModel> _categoryModel = [];
  final CollectionReference _categoryCollectionRef =
  FirebaseFirestore.instance.collection('categories');
  final CollectionReference _productCollectionRef = FirebaseFirestore.instance.collection("products");
HomeViewModel(){
  getCategory();
}


  getCategory() async {
    return await _categoryCollectionRef.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _categoryModel.add(CategoryModel.fromJson(
            value.docs[i].data() as Map<String, dynamic>
        ));
      }
      update();
    });
  }
}