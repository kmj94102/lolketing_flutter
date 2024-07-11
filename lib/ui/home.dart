import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lolketing_flutter/ui/auth/login.dart';
import 'package:lolketing_flutter/ui/my_page/my_page.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../database/auth_database.dart';
import '../style/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    _isLoginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: ColorStyle.black),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Image.asset(
                  '$imagesAddress/img_banner1.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 45, right: 45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHomeIcon(
                              '$imagesAddress/ic_board.svg', '게시판', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_event.svg', '이벤트', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_my_page.svg', '내 정보', () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const MyPageScreen();
                            }));
                          }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHomeIcon(
                              '$imagesAddress/ic_trophy.svg', '리그 정보', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_ticket.svg', '타캣 예매', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_shopping.svg', '샵', () {}),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildHomeIcon(
                              '$imagesAddress/ic_lol_guide.svg', '롤알못', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_news.svg', '뉴스', () {}),
                          _buildHomeIcon(
                              '$imagesAddress/ic_chatting.svg', '채팅', () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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

  Future<void> _isLoginCheck() async {
    try {
      await AuthDatabase().fetchUserIndex();
    } catch(e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }
}
