import 'package:get/get.dart';
import 'package:lolketing_flutter/network/purchase_service.dart';

import '../model/shop.dart';

class ShoppingController extends GetxController {
  final _cartCount = 0.obs;

  int get cartCount => _cartCount.value;

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
}
