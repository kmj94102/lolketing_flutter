import 'package:get/get.dart';

class ShopItem {
  int? goodsId;
  String? category;
  String? name;
  int? price;
  String? url;

  ShopItem({this.goodsId, this.category, this.name, this.price, this.url});

  ShopItem.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goodsId'] = goodsId;
    data['category'] = category;
    data['name'] = name;
    data['price'] = price;
    data['url'] = url;
    return data;
  }
}

class CartItem {
  final int idx;
  final String category;
  final String name;
  final int price;
  final int amount;
  final bool isChecked;
  final String image;
  final int goodsId;

  const CartItem(
      {this.idx = 0,
      this.category = '',
      this.name = '',
      this.price = 0,
      this.amount = 1,
      this.isChecked = true,
      this.image = '',
      required this.goodsId});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      idx: json['idx'],
      category: json['category'],
      name: json['name'],
      price: json['price'],
      amount: json['amount'],
      isChecked: json['isChecked'] == 1,
      image: json['image'],
      goodsId: json['goodsId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'category': category,
      'name': name,
      'price': price,
      'amount': amount,
      'isChecked': isChecked,
      'image': image,
      'goodsId': goodsId,
    };
  }
}

class ShopDetail {
  int? goodsId;
  String? category;
  String? name;
  int? price;
  List<String>? imageList;

  ShopDetail(
      {this.goodsId, this.category, this.name, this.price, this.imageList});

  ShopDetail.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    imageList = json['imageList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['goodsId'] = goodsId;
    data['category'] = category;
    data['name'] = name;
    data['price'] = price;
    data['imageList'] = imageList;
    return data;
  }

  CartItem? toCarItem() {
    if (goodsId == null ||
        category == null ||
        name == null ||
        price == null ||
        imageList?.first == null) {
      return null;
    } else {
      return CartItem(
          goodsId: goodsId!,
          category: category!,
          name: name!,
          amount: 1,
          price: price!,
          image: imageList!.first);
    }
  }
}

class PurchaseInfo {
  String? nickname;
  String? mobile;
  String? address;
  int? cash;

  PurchaseInfo({this.nickname, this.mobile, this.address, this.cash});

  PurchaseInfo.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    mobile = json['mobile'];
    address = json['address'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nickname'] = nickname;
    data['mobile'] = mobile;
    data['address'] = address;
    data['cash'] = cash;
    return data;
  }
}

class PurchaseItem {
  int? userId;
  int? goodsId;
  int? amount;
  int? productsPrice;

  PurchaseItem({this.userId, this.goodsId, this.amount, this.productsPrice});

  PurchaseItem.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    goodsId = json['goodsId'];
    amount = json['amount'];
    productsPrice = json['productsPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['goodsId'] = goodsId;
    data['amount'] = amount;
    data['productsPrice'] = productsPrice;
    return data;
  }
}
