import 'package:flutter/material.dart';
import 'package:shope/helper/extenstion.dart';
import 'package:sqflite/sqflite.dart';

class ProductModel {
  String productid;
  String name;
  String image;
  String descritption;
  String color;
  String size;
  String price;

  ProductModel({
    required this.name,
    required this.image,
    required this.descritption,
    required this.color,
    required this.size,
    required this.price,
    required this.productid,
  });

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      name: json['name']?? '',
      image: json['image']?? '',
      descritption: json['descritption']?? '',
      color: json['color']?? '',
      size: json['size']?? '',
      price: json['price']?? '',
      productid: json['productid']?? '',
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': descritption,
      'color': color,
      'size': size,
      'price': price,
      'productid': productid,
    };
  }
}