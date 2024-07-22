import 'package:flutter/material.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/common/common_dialog_contents.dart';
import 'package:lolketing_flutter/ui/dialog/common/single_dialog_button.dart';

void showRouletteExhaustionDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommonDialog(
          body: const CommonDialogContents(text: '룰렛 이용 횟수를 모두 소진하였습니다.\n티켓을 구매하여 룰렛을 더 돌려보세요'),
          bottom: SingleDialogButton(onTap: (){ Navigator.of(context).pop(); }));
      });
}
