import 'package:get/get.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_contents.dart';
import 'package:lolketing_flutter/ui/dialog/common/single_dialog_button.dart';

void showCouponsAlreadyIssuedDialog() {
  Get.dialog(
      CommonDialog(
        body: const CommonDialogContents(text: '이미 쿠폰을 발급받으셨습니다.\n내 정보에서 쿠폰을 확인해주세요.'),
        bottom: SingleDialogButton(onTap: (){
          Get.back();
        }),
      )
  );
}
