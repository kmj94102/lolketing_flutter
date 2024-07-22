import 'package:flutter/material.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_contents.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_title.dart';
import 'package:lolketing_flutter/ui/dialog/common/dual_dialog_button.dart';

void showIssuanceCompletedDialog(BuildContext context, Function() okTap) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          header: const CommonDialogTitle(text: '신규 가입 쿠폰 발급 완료'),
          body: const CommonDialogContents(text: '내 정보에서 발급받은 쿠폰을\n확인할 수 있습니다.\n바로 이동하시겠습니까?'),
          bottom: DualDialogButton(
              okTap: (){
                Navigator.of(context).pop();
                okTap();
              },
              cancelTap: () {
                Navigator.of(context).pop();
              }),
        );
      });
}
