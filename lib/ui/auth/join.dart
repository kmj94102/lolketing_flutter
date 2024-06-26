import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_text_field.dart';
import 'package:lolketing_flutter/model/login_model.dart';
import 'package:lolketing_flutter/ui/auth/search_address.dart';

import '../../network/auth_service.dart';
import '../../style/color.dart';
import '../../util/common.dart';

class JoinScreen extends StatefulWidget {
  const JoinScreen({super.key});

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  final joinInfo = JoinInfo(type: 'email');
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: ColorStyle.black),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 20),
                  child: SvgPicture.asset(
                    '$imagesAddress/ic_arrow_left.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 77, bottom: 30),
                    child: Column(
                      children: [
                        Center(
                          child: Image.asset(
                            '$imagesAddress/img_lolketing_logo.png',
                            width: 188,
                            height: 98,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomTextField(
                            icon: SvgPicture.asset('$imagesAddress/ic_user.svg',
                                fit: BoxFit.contain),
                            hintText: '아이디를 입력해주세요',
                            onChanged: (value) {
                              joinInfo.id = value;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            icon: SvgPicture.asset(
                                '$imagesAddress/ic_password.svg',
                                fit: BoxFit.contain),
                            isPassword: true,
                            hintText: '비밀번호를 입력해주세요',
                            onChanged: (value) {
                              joinInfo.password = value;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            icon: SvgPicture.asset(
                                '$imagesAddress/ic_password.svg',
                                fit: BoxFit.contain),
                            isPassword: true,
                            hintText: '비밀번호를 다시 입력해주세요',
                            onChanged: (value) {
                              joinInfo.passwordCheck = value;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                            icon: SvgPicture.asset('$imagesAddress/ic_user.svg',
                                fit: BoxFit.contain),
                            hintText: '닉네임을 입력해주세요',
                            onChanged: (value) {
                              joinInfo.nickname = value;
                            }),
                        const SizedBox(
                          height: 8,
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 7,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: ColorStyle.gray,
                              ),
                            ),
                            Center(
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 4, right: 4),
                                color: ColorStyle.black,
                                child: const Text(
                                  '선택',
                                  style: TextStyle(
                                      color: ColorStyle.gray, fontSize: 12),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextField(
                            icon: SvgPicture.asset(
                                '$imagesAddress/ic_phone.svg',
                                fit: BoxFit.contain),
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: false, decimal: false),
                            hintText: '전화번호를 입력해주세요',
                            onChanged: (value) {
                              joinInfo.mobile = value;
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          hintText: '주소를 입력해주세요',
                          enable: false,
                          icon: SvgPicture.asset(
                              '$imagesAddress/ic_address.svg',
                              fit: BoxFit.contain),
                          onChanged: (value) {
                            joinInfo.address = value;
                          },
                          controller: addressController,
                          onTap: () async {
                            final result = await Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return const SearchAddressScreen();
                            }));
                            addressController.text = result ?? ''.toString();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                      onClick: () {
                        join(context);
                      },
                      text: '회원가입')
              )
            ],
          ),
        ),
      ),
    );
  }

  void join(context) async {
    try{
      await AuthService().join(joinInfo);
      Navigator.pop(context);
    } catch(e) {
      print(e.toString());
    }
  }
}
