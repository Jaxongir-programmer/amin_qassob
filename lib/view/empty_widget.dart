import 'package:flutter/material.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  Color? colorBg;
   EmptyWidget({Key? key, this.colorBg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBg ?? Colors.transparent,
      width: getScreenWidth(context),
      alignment: Alignment.center,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesEmptyCart,
            width: 150,
            height: 150,
          ),
          const Text(
            "So'rovingiz bo'yicha hech narsa topilmadi",
            style: TextStyle(color: GREY_TEXT_COLOR, fontWeight: FontWeight.normal, fontSize: 14),
          ),
        ],
      ),
    );
  }
}


