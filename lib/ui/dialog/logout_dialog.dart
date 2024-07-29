import 'package:get/get.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_contents.dart';
import 'package:lolketing_flutter/ui/dialog/common/dual_dialog_button.dart';

void showLogoutDialog(Function() okTap) {
  Get.dialog(
      CommonDialog(
        body: const CommonDialogContents(text: '로그아웃을 하시겠습니까?'),
        bottom: DualDialogButton(
            okTap: okTap,
            cancelTap: () {
              Get.back();
            }),
      )
  );
}