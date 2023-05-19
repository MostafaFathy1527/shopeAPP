import 'package:flutter/material.dart';
import 'package:shope/helper/extenstion.dart';
class ProductModel {
  String name;
  String image;
  String description;
  Color color;
  String size;
  String price;

  ProductModel({
    required this.name,
    required this.image,
    required this.description,
    required this.color,
    required this.size,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      color : HexColor.fromHex(json['color']),
      size: json['size'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'description': description,
      'color': color != null ? color.toHex() : null,
      'size': size,
      'price': price,
    };
  }
}