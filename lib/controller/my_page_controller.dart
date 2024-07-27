import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/auth_controller.dart';
import 'package:lolketing_flutter/model/user.dart';
import 'package:lolketing_flutter/ui/auth/login.dart';

import '../network/auth_service.dart';
import '../util/common.dart';

class MyPageController extends GetxController {
  final authController = Get.find<AuthController>();
  final _user = User().obs;
  User get user => _user.value;

  void fetchMyInfo(context) async {
    try {
      _user.value = await AuthService().fetchMyInfo();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void doLogout() async {
    try {
      await authController.logout();
      Get.offAll(const LoginScreen());
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void doWithdrawal() async {
    try {
      await AuthService().withdrawal();
      await authController.logout();
      Get.offAll(const LoginScreen());
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void doCashCharging(int cash) async {
    try {
      _user.value = await AuthService().cashCharging(cash);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void doUsingCoupon(int couponId) async {
    try {
      _user.value = await AuthService().usingCoupon(couponId);
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }
}