import 'dart:async';

import 'package:shope/model/cart_product_model.dart';
import 'package:shope/model/cart_product_model.dart';
import 'package:sqflite/sqflite.dart';
import '../../../constance.dart';
import '../../../model/cart_product_model.dart';


class CartDatabaseHelper {
  CartDatabaseHelper._();
  static final CartDatabaseHelper db = CartDatabaseHelper._();
  static Database? _database; // Declare _database as nullable

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return await openDatabase(
      '$path/cart.db',
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableCartProduct(
          $columnName TEXT,
          $columnImage TEXT,
          $columnPrice TEXT,
          $columnQuantity INTEGER
        )
        ''');
      },
      version: 1,
    );
  }

  Future<List<cartProductModel>> getAllProduct() async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableCartProduct);

    List<cartProductModel> list = maps.isNotEmpty
        ? maps.map((e) {
      Map<String, dynamic> stringMap = {};
      e.forEach((key, value) {
        stringMap[key.toString()] = value;
      });
      return cartProductModel.fromJson(stringMap);
    }).toList()
        : [];

    return list;
  }
  insert(cartProductModel cartProductModel) async {
    var dbClient = await database;
    await dbClient.insert(
      tableCartProduct,
      cartProductModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
