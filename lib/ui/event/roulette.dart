import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/network/auth_service.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/ui/dialog/roulette_exhaustion_dialog.dart';
import 'package:lolketing_flutter/util/common.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  var _rouletteCount = 0;
  late AnimationController _controller;
  late Animation<double> _animation =
      Tween<double>(begin: 0, end: 0).animate(_controller);
  late double _endAngle;
  final Random _random = Random();
  bool _isFirstRun = true;

  @override
  void initState() {
    super.initState();
    _fetchRouletteCount();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_isFirstRun) {
        final rp = _getResultPoint(_animation.value.toInt());
        _insertCoupon(rp);
      } else if (status == AnimationStatus.completed && _isFirstRun) {
        _isFirstRun = false;
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      isScroll: false,
      header: const CustomHeader(
        title: 'RP 룰렛',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Text(
                  '100% 당첨 룰렛',
                  style: TextStyle(
                      color: ColorStyle.mainColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '돌리고 RP를 모아보세요!',
                  style: TextStyle(color: ColorStyle.white, fontSize: 14),
                ),
              ],
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: Container(
                      constraints: const BoxConstraints(
                        maxWidth: 310.0,
                        maxHeight: 310.0,
                      ),
                      child: Transform.rotate(
                        angle: _animation.value * pi / 180,
                        child: Image.asset(
                          '$imagesAddress/img_roulette.png',
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    '$imagesAddress/ic_position.svg',
                    width: 40,
                    height: 50,
                  ),
                )
              ],
            ),
            Text(
              _rouletteCount == 0
                  ? '룰렛 횟수를 모두 소진하였습니다.'
                  : '$_rouletteCount번 더 돌릴 수 있어요!',
              style: const TextStyle(
                  color: ColorStyle.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      bottom: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: CustomButton(
          text: '돌리기',
          onClick: _startRoulette,
        ),
      ),
    );
  }

  void _fetchRouletteCount() async {
    final count = await AuthService().fetchRouletteCount();
    setState(() {
      _rouletteCount = count;
    });
  }

  void _insertCoupon(int rp) async {
    final count = await AuthService().insertRouletteCoupon(rp);
    setState(() {
      _rouletteCount = count;
      // showSnackBar(context, '${rp}RP 쿠폰 당첨!!');
    });
  }

  void _startRoulette() {
    if (_rouletteCount <= 0) {
      showRouletteExhaustionDialog(context);
      return;
    }
    _endAngle = _random.nextInt(360).toDouble();

    _animation =
        Tween<double>(begin: 0, end: _endAngle + 1800).animate(_controller)
          ..addListener(() {
            setState(() {});
          });
    _controller.reset();
    _controller.forward();
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
