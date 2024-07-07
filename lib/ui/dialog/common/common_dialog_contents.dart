import 'package:flutter/cupertino.dart';

import '../../../style/color.dart';

class CommonDialogContents extends StatelessWidget {
  final String text;
  const CommonDialogContents({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            text,
            style: const TextStyle(
              color: ColorStyle.lightGray,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
