import 'dart:convert';

import 'package:get/get.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../model/shop.dart';
import 'package:http/http.dart' as http;


class PurchaseService {

  Future<List<ShopItem>> fetchGoodsItems() async {
    var url = '$baseUrl/purchase/select/goodsItems';
    http.Response response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final result = jsonResponse.map((item) => ShopItem.fromJson(item)).toList();
      return result;
    } else {
      return throw(jsonDecode(utf8.decode(response.bodyBytes))['detail']);
    }
  }

}