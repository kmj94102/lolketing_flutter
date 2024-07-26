import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onClick;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;

  const CustomButton(
      {Key? key,
      required this.text,
      required this.onClick,
      this.backgroundColor = ColorStyle.mainColor,
      this.textColor = ColorStyle.white,
      this.borderRadius = 3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          foregroundColor: textColor,
          backgroundColor: backgroundColor,
          textStyle: const TextStyle(
              color: ColorStyle.white,
              fontSize: 20,
              fontWeight: FontWeight.bold)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Text(text),
      ),
    );
  }
}
