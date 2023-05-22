import 'package:flutter/material.dart';
import 'package:shope/helper/extenstion.dart';
import 'package:sqflite/sqflite.dart';

class cartProductModel {
  String name;
  String image;
  String price;
  int quantity;

  cartProductModel({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  factory cartProductModel.fromJson(Map<String, dynamic> json) {
    return cartProductModel(
      name: json['name']?? '',
      image: json['image']?? '',
      quantity: json['quantity']?? '',
      price: json['price']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'quantity': quantity,
      'price': price,
    };
  }
}