import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_title.dart';
import 'package:lolketing_flutter/ui/dialog/common/single_dialog_button.dart';

import '../../model/user.dart';

class CouponListDialog extends StatefulWidget {
  final List<Coupon> list;
  final ValueChanged<int> onUseTap;

  const CouponListDialog(
      {super.key, required this.list, required this.onUseTap});

  @override
  State<CouponListDialog> createState() => _CouponListDialogState();
}

class _CouponListDialogState extends State<CouponListDialog> {
  var isUsed = true;

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      header: const CommonDialogTitle(
        text: '쿠폰함',
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildToggleButtons(isUsed, (value) {
              setState(() {
                isUsed = value;
              });
            }),
            const SizedBox(
              height: 15,
            ),
            _buildCouponList(widget.list, widget.onUseTap),
          ],
        ),
      ),
      bottom: SingleDialogButton(onTap: () {
        Get.back();
      }),
    );
  }
}

Widget _buildToggleButtons(bool isUsed, ValueChanged<bool> onTap) {
  return Container(
    decoration: BoxDecoration(
        color: ColorStyle.gray, borderRadius: BorderRadius.circular(3)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Row(
        children: [
          Expanded(
              child: GestureDetector(
            onTap: () {
              onTap(true);
            },
            child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                color: isUsed ? ColorStyle.mainColor : ColorStyle.gray,
                child: const Center(
                  child: Text(
                    '사용 가능',
                    style: TextStyle(
                        color: ColorStyle.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )),
          Expanded(
              child: GestureDetector(
            onTap: () {
              onTap(false);
            },
            child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                color: isUsed ? ColorStyle.gray : ColorStyle.mainColor,
                child: const Center(
                  child: Text(
                    '사용 완료',
                    style: TextStyle(
                        color: ColorStyle.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          )),
        ],
      ),
    ),
  );
}

Widget _buildCouponList(List<Coupon> list, ValueChanged<int> onUseTap) {
  return Container(
    height: 186,
    decoration: BoxDecoration(
        color: ColorStyle.gray,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: ColorStyle.white, width: 1)),
    child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (!list[index].isUsed) {
                onUseTap(list[index].id);
              }
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[index].getCouponName(),
                            style: const TextStyle(
                              color: ColorStyle.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            list[index].getTimeFormat(),
                            style: const TextStyle(
                              color: ColorStyle.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )),
                      Container(
                        width: 67,
                        decoration: BoxDecoration(
                            color: list[index].isUsed
                                ? ColorStyle.lightGray
                                : ColorStyle.mainColor,
                            borderRadius: BorderRadius.circular(3)),
                        child: GestureDetector(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2, bottom: 2),
                              child: Text(
                                '${list[index].rp}RP\n받기',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: ColorStyle.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: ColorStyle.lightGray,
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                )
              ],
            ),
          );
        }),
  );
}

void showCouponListDialog(
    BuildContext context, List<Coupon> list, ValueChanged<int> onUseTap) {
  Get.dialog(CouponListDialog(
    list: list,
    onUseTap: onUseTap,
  ));
}
