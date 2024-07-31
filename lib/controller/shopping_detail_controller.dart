import 'dart:math';

import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/shopping_controller.dart';
import 'package:lolketing_flutter/database/cart_database.dart';
import 'package:lolketing_flutter/model/shop.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../network/purchase_service.dart';

class ShoppingDetailController extends GetxController {
  final _item = ShopDetail().obs;
  ShopDetail get item => _item.value;

  final _amount = 1.obs;
  int get amount => _amount.value;

  final controller = ShoppingController();

  void fetchGoodsDetail(int id) async {
    try {
      _item.value = await PurchaseService().fetchGoodsDetail(id);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void insertCartItem() async {
    CartDatabase database = CartDatabase();
    final cartItem = _item.value.toCarItem();
    if(cartItem != null) {
      await database.insertCartItem(cartItem);
      controller.updateCartCount();
    }
  }

  void updateItemPlus() {
    _amount.value = min(_amount.value + 1, 10);
  }

  void updateItemMinus() {
    _amount.value = max(_amount.value - 1, 1);
  }
}
