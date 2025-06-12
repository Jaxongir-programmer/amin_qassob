
import 'package:as_toast_x/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/offer_model.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';
import '../utils/pref_utils.dart';
import '../utils/utils.dart';
import 'custom_views.dart';

class CarouselItemView extends StatefulWidget {
  final Function onClick;
  final int index;
  final OfferModel item;

  CarouselItemView({Key? key, required this.onClick, required this.index, required this.item}) : super(key: key);

  @override
  _CarouselItemViewState createState() => _CarouselItemViewState();
}

class _CarouselItemViewState extends State<CarouselItemView> {
  int height = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AsScaleAnimation(
            begin: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                  foregroundDecoration: BoxDecoration(color: WHITE.withOpacity(0.0)),
                  child:
                      // Image.asset(Assets.imagesAminQassob,width:getScreenWidth(context),fit: BoxFit.contain,)
                  CustomViews.buildNetworkImage(
                      widget.item.image,
                          height: double.maxFinite,
                          width: double.maxFinite,
                          fit: BoxFit.cover)

                  // asCachedNetworkImage(
                  //         widget.item.image,
                  //         width: getScreenWidth(context),
                  //         fit: BoxFit.cover,)
                  ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(color: BLACK.withOpacity(0.4), blurStyle: BlurStyle.outer, blurRadius: 4)],
                  gradient: LinearGradient(
                      colors: [COLOR_PRIMARY.withOpacity(.1), WHITE.withOpacity(.1), BLACK.withOpacity(.1)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              child: Container()),
          Container(
              margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: BLACK.withOpacity(.5), borderRadius: BorderRadius.circular(6)),
              child: Text(
                widget.item.title,
                style: asTextStyle(fontFamily: "p_light", color: Colors.white, size: 14),
              ))
        ],
      ),
    );
  }
}
