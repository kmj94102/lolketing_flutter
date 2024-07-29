import 'package:get/get.dart';

class ShoppingController extends GetxController {
  final _cartCount = 0.obs;
  int get cartCount => _cartCount.value;

  final tabList = ['전체', '스태츄', '피규어', '인형', '액세서리', '의류'];
}