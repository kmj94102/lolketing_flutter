import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class BaseContainer extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? bottom;
  final bool isScroll;

  const BaseContainer(
      {super.key, this.header, this.body, this.bottom, this.isScroll = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ColorStyle.black,
          child: Column(
            children: [
              header ?? const SizedBox(),
              Expanded(
                  child: isScroll
                      ? SingleChildScrollView(child: body,)
                      : body ?? const SizedBox()),
              bottom ?? const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
