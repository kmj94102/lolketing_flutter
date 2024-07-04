import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String imagesAddress = 'assets/images';
const String baseUrl = 'https://port-0-mj-api-e9btb72blgnd5rgr.sel3.cloudtype.app';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3), // 메시지가 표시되는 시간
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}