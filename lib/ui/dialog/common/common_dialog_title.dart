import 'package:flutter/cupertino.dart';
import 'package:lolketing_flutter/style/color.dart';

class CommonDialogTitle extends StatelessWidget {
  final String text;

  const CommonDialogTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            text,
            style: const TextStyle(
              color: ColorStyle.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
