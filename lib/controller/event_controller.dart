import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/auth_controller.dart';
import 'package:lolketing_flutter/network/auth_service.dart';
import 'package:lolketing_flutter/ui/dialog/coupons_already_issued_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/issuance_completed_dialog.dart';
import 'package:lolketing_flutter/util/common.dart';

class EventController extends GetxController {
  final _isIssued = true.obs;
  final authController = Get.find<AuthController>();

  void fetchNewUserCoupon() async {
    final id = authController.email;
    if (id == null) {
      showNoUserInfoSnackBar();
    } else {
      _isIssued.value = await AuthService().fetchNewUserCoupon(id);
    }
  }

  void getCouponOnTap() {
    if (_isIssued.value) {
      showCouponsAlreadyIssuedDialog();
    } else {
      _insertNewUserCoupon();
    }
  }

  void _insertNewUserCoupon() async {
    final index = authController.id;
    if (index == null) {
      showNoUserInfoSnackBar();
      return;
    }

    try {
      await AuthService().insertNewUserCoupon(index);
      showIssuanceCompletedDialog(() => {_isIssued.value = true});
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }
}
