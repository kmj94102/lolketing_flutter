import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color backgroundColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.backgroundColor = ColorStyle.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
          // primary: ColorStyle.white,
          backgroundColor: backgroundColor,
          textStyle:
              const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(text),
      ),
    );
  }
}
