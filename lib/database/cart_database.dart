import 'package:lolketing_flutter/database/database_helper.dart';
import 'package:lolketing_flutter/model/shop.dart';
import 'package:sqflite/sqflite.dart';

class CartDatabase {
  static final CartDatabase _instance = CartDatabase._internal();

  factory CartDatabase() {
    return _instance;
  }

  CartDatabase._internal();

  final DatabaseHelper _helper = DatabaseHelper();

  Future<void> insertCartItem(CartItem item) async {
    final db = await _helper.database;
    await db.insert(_helper.cart, item.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> fetchCartCount() async {
    final db = await _helper.database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT count(*) FROM ${_helper.cart}'));
    return count ?? 0;
  }
}