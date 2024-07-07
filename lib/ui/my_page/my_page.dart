import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';
import 'package:lolketing_flutter/model/grade.dart';
import 'package:lolketing_flutter/model/user.dart';
import 'package:lolketing_flutter/ui/dialog/cash_charging_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/logout_dialog.dart';
import 'package:lolketing_flutter/ui/dialog/withdrawal_dialog.dart';
import 'package:lolketing_flutter/util/common.dart';

import '../../network/auth_service.dart';
import '../../style/color.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  var _user = User();

  @override
  void initState() {
    super.initState();
    _fetchMyInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(color: ColorStyle.black),
                    child: Column(
                      children: [
                        CustomHeader(
                          title: '내 정보',
                          tailWidget:
                              SvgPicture.asset('$imagesAddress/ic_write.svg'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 15, bottom: 15),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  children: [
                                    _createGradeImage(
                                        GradeExtension.getImage(_user.grade)),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      GradeExtension.getKoreanName(_user.grade),
                                      style: const TextStyle(
                                          color: ColorStyle.mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _user.nickname,
                                      style: const TextStyle(
                                          color: ColorStyle.mainColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    Text(_user.id,
                                        style: const TextStyle(
                                          color: ColorStyle.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        )),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          '$imagesAddress/ic_phone.svg',
                                          width: 12,
                                          height: 12,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(_user.getMobileFormat(),
                                            style: const TextStyle(
                                              color: ColorStyle.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          '$imagesAddress/ic_address.svg',
                                          width: 12,
                                          height: 12,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(_user.getAddressFormat(),
                                            style: const TextStyle(
                                              color: ColorStyle.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            )),
                                      ],
                                    ),
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15),
                          child: Stack(
                            children: [
                              TweenAnimationBuilder(
                                tween: Tween<double>(
                                    begin: 0.0, end: _user.getProgress()),
                                duration: const Duration(seconds: 1),
                                builder: (context, double value, child) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: value,
                                      backgroundColor: ColorStyle.lightGray,
                                      color: ColorStyle.mainColor,
                                      minHeight: 22,
                                    ),
                                  );
                                },
                              ),
                              Center(
                                heightFactor: 1.2,
                                child: Text(
                                  _user.getPointProgress(),
                                  style: const TextStyle(
                                      color: ColorStyle.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15),
                          child: Row(
                            children: [
                              Expanded(
                                  child: _createInfoCard(
                                      'My 캐시', _user.getMyCashFormat(), '충전하기',
                                      () {
                                showCashChargingDialog(context, 1000, () {});
                              })),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                  child: _createInfoCard(
                                      'My 쿠폰',
                                      _user.getCouponProgress(),
                                      '상세보기',
                                      () {})),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: ColorStyle.white, width: 1),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: [
                                _createMyPageMenu('구매 내역', () {}),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: ColorStyle.white,
                                ),
                                _createMyPageMenu('로그 아웃', () {
                                  showLogoutDialog(context, () {
                                    Navigator.of(context).pop();
                                  });
                                }),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1,
                                  color: ColorStyle.white,
                                ),
                                _createMyPageMenu('회원 탈퇴', () {
                                  showWithdrawalDialog(context, () {
                                    Navigator.of(context).pop();
                                  });
                                }),
                              ],
                            ),
                          ),
                        )
                      ],
                    )))));
  }

  Widget _createGradeImage(String imageUrl) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorStyle.white,
          width: 1,
        ),
      ),
      child: Center(
        child: ClipOval(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: 90,
            height: 90,
          ),
        ),
      ),
    );
  }

  Widget _createInfoCard(
      String title, String content, String buttonText, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorStyle.mainColor, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: ColorStyle.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 11,
              ),
              Text(
                content,
                style: const TextStyle(
                    color: ColorStyle.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorStyle.mainColor),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                          color: ColorStyle.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _createMyPageMenu(String text, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 16, left: 15, right: 10),
        child: Row(
          children: [
            Expanded(
                child: Text(
              text,
              style: const TextStyle(
                  color: ColorStyle.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
            SvgPicture.asset('$imagesAddress/ic_next.svg')
          ],
        ),
      ),
    );
  }

  void _fetchMyInfo(context) async {
    try {
      final result = await AuthService().fetchMyInfo();
      setState(() {
        _user = result;
      });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
