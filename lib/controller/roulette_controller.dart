import 'dart:math';

import 'package:get/get.dart';
import 'package:lolketing_flutter/ui/dialog/roulette_exhaustion_dialog.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../network/auth_service.dart';

class RouletteController extends GetxController {
  final _rouletteCount = 0.obs;

  int get rouletteCount => _rouletteCount.value;
  final Random _random = Random();

  void fetchRouletteCount() async {
    final count = await AuthService().fetchRouletteCount();
    _rouletteCount.value = count;
  }

  double? getEndAngle() {
    if (_rouletteCount <= 0) {
      showRouletteExhaustionDialog();
      return null;
    } else {
      return _random.nextInt(360).toDouble();
    }
  }

  void insertCoupon(int deg) async {
    final rp = _getResultPoint(deg);
    final count = await AuthService().insertRouletteCoupon(rp);
    _rouletteCount.value = count;
    showSnackBar(message: '${rp}RP 쿠폰 당첨!!');
  }

  int _getResultPoint(int deg) {
    final currentDeg = deg % 360;

    const ranges = {
      [0, 45]: 2000,
      [46, 90]: 300,
      [91, 135]: 350,
      [136, 180]: 200,
      [181, 225]: 1000,
      [226, 270]: 250,
      [271, 315]: 450,
    };

    for (var range in ranges.keys) {
      if (currentDeg > range[0] && currentDeg < range[1]) {
        return ranges[range] ?? 250;
      }
    }

    return 250;
  }
}
