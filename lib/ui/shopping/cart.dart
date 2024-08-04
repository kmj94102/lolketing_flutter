import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/shopping_controller.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/model/shop.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/shopping/item_counter.dart';
import 'package:lolketing_flutter/util/common.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final controller = Get.find<ShoppingController>();

  @override
  void initState() {
    super.initState();
    controller.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseContainer(
        isScroll: false,
        header: const CustomHeader(
          title: '장바구니',
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 2,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 7,
                ),
                Checkbox(
                    value: controller.isAllCheck,
                    activeColor: ColorStyle.mainColor,
                    onChanged: (bool? value) { controller.updateAllCheck(value!); }),
                const Text(
                  '전체 선택',
                  style: TextStyle(color: ColorStyle.white, fontSize: 14),
                ),
                const Spacer(),
                const Text(
                  '선택 삭제',
                  style: TextStyle(color: ColorStyle.yellow, fontSize: 14),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              color: ColorStyle.gray,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
                child: controller.cartItems.isEmpty
                    ? const Center(
                        child: Text(
                          '장바구니에 추가된 상품이 없습니다',
                          style:
                              TextStyle(color: ColorStyle.gray, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: controller.cartItems.length,
                        itemBuilder: (context, index) {
                          return _buildCartItem(controller.cartItems[index]);
                        })),
            Container(
              color: ColorStyle.gray,
              height: 1,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: [
                  const Text(
                    '총 합계',
                    style: TextStyle(color: ColorStyle.white, fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    priceFormatWon(controller.totalPrice),
                    style: const TextStyle(
                        color: ColorStyle.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
        bottom:
            CustomButton(text: '선택 상품 구매하기', borderRadius: 0, onClick: () {}),
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 15, 7, 15),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorStyle.mainColor, width: 2)),
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                left: 90,
                right: 20,
                child: Text(
                  item.name,
                  style: const TextStyle(
                      color: ColorStyle.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Positioned(
                left: 90,
                top: 22,
                right: 20,
                child: Text(
                  priceFormatWon(item.price),
                  style: const TextStyle(
                      color: ColorStyle.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
            Positioned(
                left: 90,
                bottom: 0,
                child: buildItemCounter(
                    count: 1, onMinusTap: () {}, onPlusTap: () {})),
            Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: Checkbox(
                  activeColor: ColorStyle.mainColor,
                  value: item.isChecked,
                  onChanged: (bool? value) {
                    controller.updateItemCheck(item);
                  },
                ))
          ],
        ),
      ),
    );
  }
}
