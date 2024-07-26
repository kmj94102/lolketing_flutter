import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../style/color.dart';

const String imagesAddress = 'assets/images';
const String baseUrl =
    'https://port-0-mj-api-e9btb72blgnd5rgr.sel3.cloudtype.app';

void showSnackBar({required String message, String title = ''}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: ColorStyle.lightBlack,
    colorText: ColorStyle.white,
    snackPosition: SnackPosition.BOTTOM,
    borderRadius: 0,
    titleText: title.isEmpty ? const SizedBox() : null,
  );
}

String priceFormat(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}

String priceFormatWon(int amount) {
  return '${priceFormat(amount)}원';
}

String convertFormattedDate(String dateTimeString,
    {String format = 'yyyy.MM.dd'}) {

  DateTime dateTime = DateTime.parse(dateTimeString);
  DateFormat formatter = DateFormat(format);
  return formatter.format(dateTime);
}
