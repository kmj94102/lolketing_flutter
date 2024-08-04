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
    await db.insert(_helper.cart, item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> fetchCartCount() async {
    final db = await _helper.database;
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT count(*) FROM ${_helper.cart}'));
    return count ?? 0;
  }

  Future<List<CartItem>> fetchCartItems() async {
    final db = await _helper.database;
    List<Map<String, dynamic>> result = await db.query(_helper.cart);
    return result.isEmpty
        ? []
        : result.map((item) => CartItem.fromJson(item)).toList();
  }

  Future<CartItem> updateCartItem(CartItem item) async {
    final db = await _helper.database;
    final updateItem = item.toJson();
    updateItem['isChecked'] = item.isChecked ? 0 : 1;

    int result = await db.update(_helper.cart, updateItem, where: 'idx = ?', whereArgs: [item.idx]);
    if(result == 1) {
      return CartItem.fromJson(updateItem);
    } else {
      return item;
    }
  }

  Future<List<CartItem>> updateCartItemAll(bool value) async {
    final db = await _helper.database;
    final isChecked = value ? 1 : 0;
    await db.rawUpdate('UPDATE ${_helper.cart} SET isChecked = $isChecked');
    return fetchCartItems();
  }
}
