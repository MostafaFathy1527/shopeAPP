  import 'package:path/path.dart';
import 'package:shope/model/productmodel.dart';
  import 'package:sqflite/sqflite.dart';
  import 'package:hive/hive.dart';
  import '../../../constance.dart';
  import '../../../model/cart_product_model.dart';
  import 'package:hive/hive.dart';
  import '../../../model/cart_product_model.dart';

  class CartDatabaseHelper {
    static const String boxName = 'cartProductBox';

    static Future<Box> getBox() async {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      }
      return Hive.box(boxName);
    }

    static Future<List<CartProductModel>> getAllProduct() async {
      final box = await getBox();
      return box.values.map((product) => CartProductModel.fromJson(product)).toList();
    }

    static Future<void> insert(CartProductModel model) async {
      final box = await getBox();
      await box.put(model.productid, model.toJson());
    }
  }
