import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/shopping/cart_button.dart';
import 'package:lolketing_flutter/util/common.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controller/shopping_controller.dart';
import '../../controller/shopping_detail_controller.dart';
import 'item_counter.dart';

class ShoppingDetail extends StatefulWidget {
  const ShoppingDetail({super.key});

  @override
  State<ShoppingDetail> createState() => _ShoppingDetailState();
}

class _ShoppingDetailState extends State<ShoppingDetail> {
  final detailController = Get.put(ShoppingDetailController());
  final controller = Get.find<ShoppingController>();
  final PageController _pageController = PageController();

  late int goodId = Get.arguments['id'];

  @override
  void initState() {
    super.initState();
    detailController.fetchGoodsDetail(goodId);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseContainer(
        header: CustomHeader(
          title: '',
          tailWidget: buildCartIcon(controller.cartCount),
        ),
        body: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 310,
                  child: PageView.builder(
                      controller: _pageController,
                      itemCount: detailController.item.imageList?.length,
                      itemBuilder: (context, index) => Container(
                            color: ColorStyle.white,
                            child: detailController.item.imageList == null
                                ? const SizedBox()
                                : Image.network(
                                    detailController.item.imageList![index]),
                          )),
                ),
                Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: detailController.item.imageList?.length ?? 0,
                        effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: ColorStyle.lightGray,
                            activeDotColor: ColorStyle.mainColor),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '[${detailController.item.category}]',
                    style: const TextStyle(
                        color: ColorStyle.gray,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${detailController.item.name}',
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
                      buildItemCounter(
                          count: detailController.amount,
                          onMinusTap: () {
                            detailController.updateItemMinus();
                          },
                          onPlusTap: () {
                            detailController.updateItemPlus();
                          }),
                      Expanded(
                          child: Text(
                        priceFormatWon(detailController.amount * (detailController.item.price ?? 0)),
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
                    onClick: () {
                      detailController.insertCartItem();
                    })),
            Expanded(
                child: CustomButton(
                    text: '바로구매',
                    backgroundColor: ColorStyle.mainColor,
                    borderRadius: 0,
                    onClick: () {}))
          ],
        ),
      ),
    );
  }
}
