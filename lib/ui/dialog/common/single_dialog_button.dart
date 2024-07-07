import 'package:flutter/cupertino.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';

class SingleDialogButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const SingleDialogButton({super.key, this.text = '확인', required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomButton(text: text, onClick: onTap));
  }
}