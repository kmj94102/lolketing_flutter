import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../../style/color.dart';

Widget buildItemCounter(
    {required int count,
    required Function() onMinusTap,
    required Function() onPlusTap}) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: ColorStyle.white, width: 1),
      borderRadius: BorderRadius.circular(5.0),
    ),
    width: 108,
    height: 34,
    child: Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
            onTap: onMinusTap,
            child: SvgPicture.asset('$imagesAddress/ic_minus.svg')),
        const SizedBox(
          width: 5,
        ),
        Container(
          color: ColorStyle.gray,
          width: 1,
          height: 108,
        ),
        Expanded(
            child: Text(
          '$count',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: ColorStyle.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        )),
        Container(
          color: ColorStyle.gray,
          width: 1,
          height: 108,
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
            onTap: onPlusTap,
            child: SvgPicture.asset('$imagesAddress/ic_plus.svg')),
        const SizedBox(
          width: 5,
        ),
      ],
    ),
  );
}
