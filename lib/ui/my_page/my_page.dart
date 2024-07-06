import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolketing_flutter/custom/custom_header.dart';

import '../../style/color.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
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
                      children: const [
                        CustomHeader(title: '내 정보'),

                      ],
                    )
                )
            )
        )
    );
  }
}
