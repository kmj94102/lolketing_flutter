import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WidgetCommunicator {
  static const MethodChannel _channel = MethodChannel('com.example.myapp/widget');

  static Future<void> updateWidget(String data) async {
    try {
      await _channel.invokeMethod('updateWidget', {"data": data});
    } on PlatformException catch (e) {
      Get.log("Failed to update widget: '${e.message}'.");
    }
  }
}