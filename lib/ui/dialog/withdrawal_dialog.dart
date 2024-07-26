import 'package:flutter/material.dart';
import 'package:lolketing_flutter/custom/custom_text_field.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_title.dart';
import 'package:lolketing_flutter/ui/dialog/common/dual_dialog_button.dart';

void showWithdrawalDialog(BuildContext context, Function() okTap) {
  var confirmationText = '';

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          header: const CommonDialogTitle(text: '회원 탈퇴'),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  '회원 탈퇴를 진행하시려면\n아래의 입력창에 \'회원 탈퇴\'를 입력 후\n탈퇴하기 버튼을 눌러주세요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorStyle.lightGray, fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomTextField(hintText: '회원 탈퇴', onChanged: (value) { confirmationText = value; })
              ],
            ),
          ),
          bottom: DualDialogButton(
              okTap: () {
                if(confirmationText == '회원 탈퇴') {
                  okTap();
                } else {
                  // showSnackBar(context, '회원 탈퇴를 정확히 입력해주세요' );
                }
              },
              okButtonColor: ColorStyle.red,
              okButtonText: '탈퇴하기',
              cancelTap: () {
                Navigator.of(context).pop();
              }),
        );
      });
}
