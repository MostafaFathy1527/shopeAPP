import 'package:hive/hive.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:shope/model/productmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart';

part 'cart_product_model.g.dart';


@HiveType(typeId: 0)
class CartProductModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String image;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String price;

  @HiveField(4)
  String productid;

  CartProductModel({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.productid,
  });

  factory CartProductModel.fromJson(Map<dynamic, dynamic> json) {
    return CartProductModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      quantity: json['quantity'] ?? '',
      price: json['price'] ?? '',
      productid: json['productid'] ?? '',
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
      'productid': productid,
    };
  }
}
