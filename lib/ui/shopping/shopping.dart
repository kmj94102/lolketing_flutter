import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/shopping_controller.dart';
import 'package:lolketing_flutter/custom/custom_image_header.dart';
import 'package:lolketing_flutter/model/shop.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/ui/shopping/shopping_detail.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../../style/color.dart';
import 'cart_button.dart';

class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(ShoppingController());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: controller.tabList.length, vsync: this);
    controller.fetchGoodsItems();
    controller.updateCartCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseContainer(
        header: CustomImageHeader(
          title: '굿즈 쇼핑',
          imageAddress: '$imagesAddress/img_shop.png',
          tailIcon: GestureDetector(
            onTap: () {},
            child: buildCartIcon(controller.cartCount),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: _tabItems(),
              isScrollable: true,
              indicatorColor: ColorStyle.mainColor,
              labelColor: ColorStyle.mainColor,
              unselectedLabelColor: ColorStyle.white,
              controller: _tabController,
              tabAlignment: TabAlignment.start,
              onTap: (index) {
                controller.updateTabSelectIndex(index);
              },
            ),
            Expanded(
                child: GridView.builder(
              itemCount: controller.shopItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 230),
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 30),
              itemBuilder: (BuildContext context, int index) =>
                  _buildShopItem(controller.shopItems[index]),
            ))
          ],
        ),
        isScroll: false,
      ),
    );
  }

  List<Widget> _tabItems() {
    return controller.tabList.map((item) => Tab(text: item)).toList();
  }

  Widget _buildShopItem(ShopItem item) {
    return GestureDetector(
      onTap: () async {
        await Get.to(const ShoppingDetail(), arguments: {'id': item.goodsId});
        controller.updateCartCount();
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorStyle.gray, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                ),
                child: Image.network(
                  '${item.url}',
                  width: MediaQuery.of(context).size.width,
                  height: 123,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '[${item.category}]',
                style: const TextStyle(color: ColorStyle.gray, fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${item.name}',
                style: const TextStyle(color: ColorStyle.white, fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                priceFormatWon(item.price ?? 0),
                style: const TextStyle(
                    color: ColorStyle.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
