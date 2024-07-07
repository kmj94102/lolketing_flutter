import 'package:flutter/cupertino.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/style/color.dart';

class DualDialogButton extends StatelessWidget {
  final String okButtonText;
  final Function() okTap;
  final Color okButtonColor;
  final String cancelButtonText;
  final Function() cancelTap;
  final Color cancelButtonColor;

  const DualDialogButton(
      {super.key,
      this.okButtonText = '확인',
      required this.okTap,
      this.okButtonColor = ColorStyle.mainColor,
      this.cancelButtonText = '취소',
      required this.cancelTap,
      this.cancelButtonColor = ColorStyle.gray});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
            text: cancelButtonText,
            onClick: cancelTap,
            backgroundColor: cancelButtonColor,
          )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: CustomButton(
            text: okButtonText,
            onClick: okTap,
            backgroundColor: okButtonColor,
          ))
        ],
      ),
    );
  }
}
