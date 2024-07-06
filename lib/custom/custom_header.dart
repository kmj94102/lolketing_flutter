import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lolketing_flutter/style/color.dart';
import 'package:lolketing_flutter/util/common.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final Widget? tailWidget;

  const CustomHeader({Key? key, required this.title, this.tailWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 16, bottom: 16),
                    child: SvgPicture.asset(
                      '$imagesAddress/ic_arrow_left.svg',
                      width: 24,
                      height: 24,
                    )),
              ),
              tailWidget == null
                  ? const SizedBox()
                  : Positioned(right: 20, child: tailWidget!),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                      color: ColorStyle.mainColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: ColorStyle.gray,
          )
        ],
      ),
    );
  }
}
