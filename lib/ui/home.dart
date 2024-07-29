import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/ui/event/event.dart';
import 'package:lolketing_flutter/ui/my_page/my_page.dart';
import 'package:lolketing_flutter/ui/shopping/shopping.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../style/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseContainer(
        isScroll: false,
        header: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: Image.asset(
            '$imagesAddress/img_banner1.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.only(left: 45, right: 45),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHomeIcon(
                          '$imagesAddress/ic_board.svg', '게시판', () {}),
                      _buildHomeIcon('$imagesAddress/ic_event.svg', '이벤트',
                          () => Get.to(const EventScreen())),
                      _buildHomeIcon('$imagesAddress/ic_my_page.svg', '내 정보',
                          () => Get.to(const MyPageScreen())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHomeIcon(
                          '$imagesAddress/ic_trophy.svg', '리그 정보', () {}),
                      _buildHomeIcon(
                          '$imagesAddress/ic_ticket.svg', '타캣 예매', () {}),
                      _buildHomeIcon('$imagesAddress/ic_shopping.svg', '샵',
                          () => Get.to(const ShoppingScreen())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildHomeIcon(
                          '$imagesAddress/ic_lol_guide.svg', '롤알못', () {}),
                      _buildHomeIcon('$imagesAddress/ic_news.svg', '뉴스', () {}),
                      _buildHomeIcon(
                          '$imagesAddress/ic_chatting.svg', '채팅', () {}),
                    ],
                  ),
                ])));
  }

  Widget _buildHomeIcon(String imageAddress, String title, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SvgPicture.asset(
            imageAddress,
            width: 64,
            height: 64,
          ),
          Text(
            title,
            style: const TextStyle(
                color: ColorStyle.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
