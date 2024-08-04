import 'package:get/get.dart';
import 'package:lolketing_flutter/database/cart_database.dart';
import 'package:lolketing_flutter/network/purchase_service.dart';

import '../model/shop.dart';

class ShoppingController extends GetxController {
  final _cartCount = 0.obs;
  int get cartCount => _cartCount.value;

  final _cartItems = <CartItem>[].obs;
  List<CartItem> get cartItems => _cartItems;

  int get totalPrice => _cartItems.where((item) => item.isChecked).fold(0, (sum, item) => sum + item.price);
  bool get isAllCheck => _cartItems.every((item) => item.isChecked);

  final tabList = ['전체', '스태츄', '피규어', '인형', '액세서리', '의류'];
  var _selectIndex = 0;

  final _originShopItems = <ShopItem>[];
  final _shopItems = <ShopItem>[].obs;

  List<ShopItem> get shopItems => _shopItems;

  void fetchGoodsItems() async {
    final items = await PurchaseService().fetchGoodsItems();
    _originShopItems.assignAll(items);
    _updateList();
  }

  void updateTabSelectIndex(int index) {
    _selectIndex = index;
    _updateList();
  }

  void _updateList() {
    _shopItems.value = _selectIndex == 0
        ? _originShopItems
        : _originShopItems
            .where((item) => item.category == tabList[_selectIndex])
            .toList();
  }

  void updateCartCount() async {
    CartDatabase databaseClient = CartDatabase();
    _cartCount.value = await databaseClient.fetchCartCount();
    Get.log('count: ${_cartCount.value}');
  }

  void fetchCartItems() async {
    CartDatabase databaseClient = CartDatabase();
    _cartItems.assignAll(await databaseClient.fetchCartItems());
    for (var item in _cartItems) {
      Get.log('${item.name} / ${item.isChecked}');
    }
  }

  void updateItemCheck(CartItem item) async {
    try {
      CartDatabase databaseClient = CartDatabase();
      final result = await databaseClient.updateCartItem(item);
      final index = _cartItems.indexWhere((e) => e.idx == item.idx);
      _cartItems[index] = result;
    } catch(e) {
      Get.log(e.toString());
    }
  }

  void updateAllCheck(bool value) async {
    CartDatabase databaseClient = CartDatabase();
    final newList = await databaseClient.updateCartItemAll(value);

    _cartItems.clear();
    _cartItems.assignAll(newList);
  }
}
