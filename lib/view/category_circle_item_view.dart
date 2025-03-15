import 'package:flutter/material.dart';

import '../model/category_model.dart';
import '../utils/app_colors.dart';
import 'custom_views.dart';

class CategoryItemView extends StatelessWidget {
  int index;
  final CategoryModel item;

  CategoryItemView({required this.item, required this.index, Key? key}) : super(key: key);

  // GlobalKey containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
            color: WHITE,
            border: Border.all(color: BACKGROUND_COLOR),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomViews.buildNetworkImage(item.cat_image, fit: BoxFit.contain, width: 80, height: 80),
            ),
          ),
        ),
        Container(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 4),
            child: Text(
              "${item.title}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: BLACK_COLOR, fontSize: 13, fontWeight: FontWeight.w600),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
