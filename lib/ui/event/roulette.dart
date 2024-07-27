import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/roulette_controller.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/util/common.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with SingleTickerProviderStateMixin {
  final rouletteController = Get.put(RouletteController());
  late AnimationController _controller;
  late Animation<double> _animation =
      Tween<double>(begin: 0, end: 0).animate(_controller);
  bool _isFirstRun = true;


  @override
  void initState() {
    super.initState();
    rouletteController.fetchRouletteCount();

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        if(_isFirstRun) {
          _isFirstRun = false;
          return;
        }
        rouletteController.insertCoupon(_animation.value.toInt());
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
            const Column(
              children: [
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
              rouletteController.rouletteCount == 0
                  ? '룰렛 횟수를 모두 소진하였습니다.'
                  : '${rouletteController.rouletteCount}번 더 돌릴 수 있어요!',
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

  void _startRoulette() {
    final endAngle = rouletteController.getEndAngle();

    if(endAngle != null) {
      _animation =
      Tween<double>(begin: 0, end: endAngle + 1800).animate(_controller)
        ..addListener(() {
          setState(() {});
        });
      _controller.reset();
      _controller.forward();
    }
  }
}
