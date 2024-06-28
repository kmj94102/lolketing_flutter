import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final Widget? icon;
  final bool enable;
  final bool isPassword;
  final int maxLength;
  final int maxLine;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final TextEditingController? controller;

  const CustomTextField({Key? key,
    required this.hintText,
    required this.onChanged,
    this.icon,
    this.enable = true,
    this.isPassword = false,
    this.maxLength = 100,
    this.maxLine = 1,
    this.onTap,
    this.textInputAction,
    this.keyboardType,
    this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: isPassword,
        maxLength:11,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: ColorStyle.gray),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyle.gray),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyle.mainColor),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: ColorStyle.gray),
          ),
          prefixIcon: icon == null
              ? null
              : Container(
            width: 24,
            height: 24,
            padding: const EdgeInsets.all(8),
            child: icon,
          ),
        ),
        style: const TextStyle(color: ColorStyle.white),
        onChanged: onChanged,
        enabled: enable,
      ),
      Positioned.fill(
          child: GestureDetector(
            onTap: onTap,
          ))
    ]);
  }
}
