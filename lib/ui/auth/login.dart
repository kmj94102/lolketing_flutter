import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:lolketing_flutter/controller/auth_controller.dart';
import 'package:lolketing_flutter/custom/custom_button.dart';
import 'package:lolketing_flutter/custom/custom_text_field.dart';
import 'package:lolketing_flutter/structure/base_container.dart';
import 'package:lolketing_flutter/ui/auth/join.dart';
import 'package:lolketing_flutter/util/common.dart';
import 'package:lolketing_flutter/style/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var idController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    Get.find<AuthController>().login(
        id: idController.text.trim(),
        password: passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      header: Padding(
        padding: const EdgeInsets.only(top: 117),
        child: Image.asset(
          '$imagesAddress/img_lolketing_logo.png',
          width: 188,
          height: 98,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            CustomTextField(
              controller: idController,
              hintText: '아이디를 입력해주세요',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              icon: SvgPicture.asset('$imagesAddress/ic_user.svg',
                  fit: BoxFit.contain),
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: '비밀번호를 입력해주세요',
              isPassword: true,
              icon: SvgPicture.asset('$imagesAddress/ic_password.svg',
                  fit: BoxFit.contain),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                text: '로그인',
                onClick: () {
                  login();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 22, bottom: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '비밀번호 찾기',
                    style: TextStyle(color: ColorStyle.mainColor, fontSize: 16),
                  ),
                  GestureDetector(
                    child: const Text(
                      '회원가입',
                      style:
                          TextStyle(color: ColorStyle.mainColor, fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const JoinScreen();
                      }));
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: ColorStyle.lightGray,
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 3, 199, 90),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Image.asset(
                      '$imagesAddress/img_logo_naver.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '네이버 로그인',
                    style: TextStyle(
                        color: ColorStyle.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            MaterialButton(
              onPressed: () {},
              color: const Color.fromARGB(255, 254, 229, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Image.asset(
                      '$imagesAddress/img_logo_kakao.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '카카오 로그인',
                    style: TextStyle(
                        color: ColorStyle.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
