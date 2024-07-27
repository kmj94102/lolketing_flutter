import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lolketing_flutter/controller/event_controller.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/ui/event/roulette.dart';
import 'package:lottie/lottie.dart';

import '../../style/color.dart';
import '../../util/common.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen>
    with SingleTickerProviderStateMixin {
  final eventController = Get.put(EventController());

  @override
  void initState() {
    super.initState();
    eventController.fetchNewUserCoupon();
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      header: const CustomHeader(
        title: '이벤트',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 15, bottom: 30),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              _createEventItem(
                  context: context,
                  eventNumber: 1,
                  title: '신규 가입 웰컴 선물',
                  contents: const TextSpan(
                      text: '신규 가입 기념\n500RP 쿠폰 발급',
                      style:
                          TextStyle(color: ColorStyle.lightGray, fontSize: 16)),
                  animationAddress: '$imagesAddress/hello.json',
                  buttonText: '쿠폰 받기',
                  onTap: eventController.getCouponOnTap),
              const SizedBox(
                height: 20,
              ),
              _createEventItem(
                  context: context,
                  eventNumber: 2,
                  title: '티켓 예매 이벤트',
                  contents: const TextSpan(
                      text: '티켓 1장 당 룰렛 1회 이용 가능\n티켓 구매하시고 추가 ',
                      style: TextStyle(
                          color: ColorStyle.lightGray,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'RP ',
                            style: TextStyle(color: ColorStyle.mainColor)),
                        TextSpan(
                          text: '받아가세요',
                        ),
                        TextSpan(
                            text: '\n\n해당 이벤트는 횟 수 제한 없이 참여 가능합니다. ',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            )),
                      ]),
                  animationAddress: '$imagesAddress/ticket.json',
                  buttonText: '룰렛 페이지 이동',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const RouletteScreen();
                    }));
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createEventItem(
      {required BuildContext context,
      required int eventNumber,
      required String title,
      required TextSpan contents,
      required String animationAddress,
      required String buttonText,
      required Function() onTap}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: ColorStyle.lightBlack,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: ColorStyle.white, width: 1)),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorStyle.mainColor,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Text(
                'Event $eventNumber',
                style: const TextStyle(
                  color: ColorStyle.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            title,
            style: const TextStyle(
                color: ColorStyle.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: contents,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 15,
          ),
          Lottie.asset(animationAddress,
              repeat: true, reverse: false, animate: true, width: 130, height: 130),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
                color: ColorStyle.subColor,
                borderRadius: BorderRadius.circular(15)),
            child: GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 10, right: 10),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: ColorStyle.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
