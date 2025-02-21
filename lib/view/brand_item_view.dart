import 'package:amin_qassob/utils/pref_utils.dart';
import 'package:amin_qassob/view/custom_views.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/brand_model.dart';
import '../screen/main/product_list/product_list_screen.dart';

class BrandItemView extends StatefulWidget {
  final BrandModel brand;

  BrandItemView(this.brand);

  @override
  State<StatefulWidget> createState() {
    return BrandItemViewState();
  }
}

class BrandItemViewState extends State<BrandItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.greenAccent.withOpacity(0.2)),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ]),
      margin: const EdgeInsets.all(6),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomViews.buildNetworkImage(widget.brand.image)),
          Container(
              decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            border: Border.all(color: Colors.greenAccent.withOpacity(0.2)),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                widget.brand.brendName,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 2,

                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}
