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
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CustomViews.buildNetworkImage(item.image, fit: BoxFit.fill, width: 80, height: 80),
        ),
        Container(
          width: 100,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 4),
            child: Text(
              "${item.title}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: BLACK_COLOR,
                  fontSize: 13,
                  fontWeight: FontWeight.w600
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}
