import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/ui/shopping/cart.dart';

import '../../style/color.dart';
import '../../util/common.dart';

Widget buildCartIcon(int cartCount) {
  return GestureDetector(
    onTap: () {
      Get.to(const CartScreen());
    },
    child: Stack(
      children: [
        SvgPicture.asset(
          '$imagesAddress/ic_cart.svg',
          width: 24,
          height: 24,
        ),
        cartCount < 1
            ? const SizedBox()
            : Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Container(
              width: 15,
              height: 15,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorStyle.mainColor,
              ),
              child: Center(
                child: Text(
                  '$cartCount',
                  style: const TextStyle(
                      color: ColorStyle.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
      ],
    ),
  );
}
