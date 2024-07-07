import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolketing_flutter/style/color.dart';

class CommonDialog extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Widget? bottom;

  const CommonDialog({Key? key, this.header, this.body, this.bottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: ColorStyle.white, width: 1)),
            backgroundColor: ColorStyle.lightBlack,
            child: Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 30, left: 20, right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  header ?? Container(),
                  body ?? Container(),
                  bottom ?? Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
