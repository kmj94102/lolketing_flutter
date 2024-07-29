import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/style/color.dart';

import '../util/common.dart';

class CustomImageHeader extends StatelessWidget {
  final String title;
  final String imageAddress;
  final Color backgroundColor;
  final Widget? tailIcon;

  const CustomImageHeader(
      {Key? key,
      required this.title,
      required this.imageAddress,
      this.backgroundColor = ColorStyle.black,
      this.tailIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Image.asset(
            imageAddress,
            width: MediaQuery.of(context).size.width,
            height: 250,
            fit: BoxFit.fitHeight,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: SvgPicture.asset(
                '$imagesAddress/ic_arrow_left.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 56, left: 20),
              child: Text(
                title,
                style: const TextStyle(
                    color: ColorStyle.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold),
              )),
          tailIcon != null
              ? Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 16, right: 20),
                      child: tailIcon))
              : const SizedBox(),
        ],
      ),
    );
  }
}
