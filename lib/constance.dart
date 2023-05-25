import 'package:flutter/material.dart';

const primaryColor =Color.fromRGBO(0, 197, 105, 1)
;const primaryColorLight =Color.fromRGBO(0, 197, 105, 0.6392156862745098);
final String tableCartProduct = 'cartProduct';
final String columnName = 'name';
final String columnImage = 'image';
final String columnQuantity = 'quantity';
final String columnPrice = 'Price';
final String columnProductId = 'productid';
const CACHED_USER_DATA = 'CACHED_USER_DATA';

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  deliveryTime,
  addAddress,
  summary,
}
