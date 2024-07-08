import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String imagesAddress = 'assets/images';
const String baseUrl = 'https://port-0-mj-api-e9btb72blgnd5rgr.sel3.cloudtype.app';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

String priceFormat(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}

String priceFormatWon(int amount) {
  return '${priceFormat(amount)}원';
}