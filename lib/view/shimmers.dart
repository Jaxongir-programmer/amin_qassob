import 'package:amin_qassob/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/app_colors.dart';

Widget topProductShimmer({required BuildContext context}) {
  return SizedBox(
    height: 190,
    child: Shimmer.fromColors(
        baseColor: BLACK.withOpacity(.1),
        highlightColor: WHITE,
        child: ListView.separated(
          padding: const EdgeInsets.only(left: 20, right: 20),
          itemCount: 3,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
              height: 190,
              width: 135,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 15,
            );
          },
        )),
  );
}

Widget catalogShimmer({required BuildContext context}) {
  return Shimmer.fromColors(
      baseColor: BLACK.withOpacity(.1),
      highlightColor: WHITE,
      // loop: 5,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemCount: 15,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
            height: 60,
            width: getScreenWidth(context),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ));
}

Widget orderShimmer({required BuildContext context}) {
  return Shimmer.fromColors(
      baseColor: BLACK.withOpacity(.1),
      highlightColor: WHITE,
      // loop: 5,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 20, right: 20),
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (ctx, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
            height: 150,
            width: getScreenWidth(context),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 15,
          );
        },
      ));
}

Widget productsShimmer({required BuildContext context}) {
  return GridView.builder(
    primary: false,
    padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.62),
    itemCount: 6,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: BLACK.withOpacity(.1),
        highlightColor: WHITE,
        child: Container(
          width: getScreenWidth(context),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey.shade200,
          ),
        ),
      );
    },
  );
}

Widget categoriesShimmer({required BuildContext context}) {
  return Shimmer.fromColors(
      baseColor: BLACK.withOpacity(.1),
      highlightColor: WHITE,
      child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 20),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.25),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
            // height: 190,
            // width: 135,
          );
        },
      ));
}
