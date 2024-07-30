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