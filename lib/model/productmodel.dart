import 'package:flutter/material.dart';
import 'package:shope/helper/extenstion.dart';
class ProductModel {
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
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name']?? '',
      image: json['image']?? '',
      descritption: json['descritption']?? '',
      color: json['color']?? '',
      size: json['size']?? '',
      price: json['price']?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': descritption,
      'color': color,
      'size': size,
      'price': price,
    };
  }
}