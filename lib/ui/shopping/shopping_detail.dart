import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/shopping_controller.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/model/shop.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/shopping/cart_button.dart';
import 'package:lolketing_flutter/util/common.dart';

class ShoppingDetail extends StatefulWidget {
  const ShoppingDetail({super.key});

  @override
  State<ShoppingDetail> createState() => _ShoppingDetailState();
}

class _ShoppingDetailState extends State<ShoppingDetail> {
  final controller = Get.find<ShoppingController>();
  late ShopItem item = Get.arguments as ShopItem;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      header: CustomHeader(
        title: '',
        tailWidget: buildCartIcon(controller.cartCount),
      ),
      body: Column(
        children: [
          Container(
              color: ColorStyle.white,
              child: Image.network(
                '${item.url}',
                width: MediaQuery.of(context).size.width,
                height: 310,
                fit: BoxFit.fitHeight,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[${item.category}]',
                  style: const TextStyle(
                      color: ColorStyle.gray,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  '${item.name}',
                  style: const TextStyle(
                      color: ColorStyle.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: ColorStyle.subColor,
                      width: 108,
                      height: 34,
                    ),
                    Expanded(
                        child: Text(
                      priceFormatWon(item.price ?? 0),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: ColorStyle.mainColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                      ),
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
      bottom: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: CustomButton(
                  text: '장바구니 담기',
                  backgroundColor: ColorStyle.gray,
                  borderRadius: 0,
                  onClick: () {})),
          Expanded(
              child: CustomButton(
                  text: '바로구매',
                  backgroundColor: ColorStyle.mainColor,
                  borderRadius: 0,
                  onClick: () {}))
        ],
      ),
    );
  }
}
