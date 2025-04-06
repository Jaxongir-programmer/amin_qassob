import 'dart:core';
import 'dart:developer';

import 'package:amin_qassob/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import '../../../lang.g.dart';
import '../../../utils/utils.dart';

class SearchField extends StatelessWidget {
  Function onClickSearch;
  Function onClickFilter;

  SearchField({super.key, required this.onClickSearch, required this.onClickFilter});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: (){
                onClickSearch();
              },
              child: TextField(
                controller: searchController,
                enabled: false,
                onChanged: (value) => log(value),
                decoration: InputDecoration(
                  hintText: LocaleKeys.search_products.tr(),
                  prefixIcon: Image.asset(
                    Assets.profileSearch,
                    color: PRIMARY_COLOR,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFFBDBDBD),
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF212121),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   width: 8,
          // ),
          // MaterialButton(
          //   minWidth: 50,
          //   onPressed: () {
          //     clearFocus(context);
          //     onClickFilter();
          //   },
          //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          //   color: PRIMARY_COLOR,
          //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          //   child: Image.asset(
          //     Assets.profileFilter2x,
          //     width: 26,
          //     height: 26,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
