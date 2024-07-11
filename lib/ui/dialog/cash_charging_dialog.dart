import 'package:flutter/material.dart';
import 'package:lolketing_flutter/custom/custom_text_field.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_title.dart';
import 'package:lolketing_flutter/ui/dialog/common/dual_dialog_button.dart';
import 'package:lolketing_flutter/util/common.dart';

void showCashChargingDialog(
    BuildContext context, int myCash, ValueChanged<int> onCharging) {
  var chargingCash = 0;

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          header: const CommonDialogTitle(
            text: '캐시 충전',
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildCashChargingGuide(),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Text(
                      'My 캐시',
                      style:
                          TextStyle(color: ColorStyle.lightGray, fontSize: 16),
                    ),
                    Expanded(
                        child: Text(
                      priceFormatWon(myCash),
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                          color: ColorStyle.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(
                  hintText: '충전할 금액',
                  onChanged: (value) {
                    try {
                      chargingCash = int.parse(value);
                    } catch (e){ e.toString(); }
                  },
                  keyboardType: TextInputType.number,
                  suffix: const Text(
                    '원',
                    style: TextStyle(color: ColorStyle.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
          bottom: DualDialogButton(
              okTap: () {
                onCharging(chargingCash);
                Navigator.of(context).pop();
              },
              okButtonText: '충전하기',
              cancelTap: () {
                Navigator.of(context).pop();
              }),
        );
      });
}

Widget _buildCashChargingGuide() {
  return RichText(
    text: const TextSpan(
        text: "'롤켓팅'의 캐시는 ",
        style: TextStyle(color: ColorStyle.lightGray, fontSize: 14),
        children: [
          TextSpan(
              text: '가상 머니', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '입니다.\n원하시는 충전 금액을 입력하시고\n충전하기 버튼을 눌러주세요.\n\n'),
          TextSpan(
              text: '최소 충전 ',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: ColorStyle.mainColor)),
          TextSpan(text: '금액 '),
          TextSpan(
              text: '1,000원', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '이며\n'),
          TextSpan(
              text: '최대 보유 캐시',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: ColorStyle.mainColor)),
          TextSpan(text: '는 '),
          TextSpan(text: '1억 원', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: '입니다.'),
        ]),
    textAlign: TextAlign.center,
  );
}
