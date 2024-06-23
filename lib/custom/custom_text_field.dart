import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Icon? icon;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: ColorStyle.gray),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.gray),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.mainColor),
        ),
        prefixIcon: icon,
      ),
      style: const TextStyle(color: ColorStyle.white),
      onChanged: onChanged,
    );
  }
}
