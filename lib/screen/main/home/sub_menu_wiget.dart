import 'package:amin_qassob/generated/assets.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/utils/pref_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class SubMenuWiget extends StatefulWidget {
  Function onTapCatalog;
  Function onTapFavorite;
  Function onTapLogin;
  Function onTapOrders;
  SubMenuWiget({Key? key, required this.onTapCatalog, required this.onTapFavorite, required this.onTapLogin, required this.onTapOrders}) : super(key: key);

  @override
  _SubMenuWigetState createState() => _SubMenuWigetState();
}

class _SubMenuWigetState extends State<SubMenuWiget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                widget.onTapCatalog();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: GREY_LIGHT_COLOR, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.profileCategory,
                      color: Colors.black,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Katalog",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8,),
          if(PrefUtils.getToken()=="")Expanded(
            child: InkWell(
              onTap: (){
                widget.onTapLogin();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: GREY_LIGHT_COLOR, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.profileLogin, color: Colors.black,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Kirish",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          if(PrefUtils.getToken()!="")Expanded(
            child: InkWell(
              onTap: (){
                widget.onTapOrders();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: GREY_LIGHT_COLOR, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.profileBag, color: Colors.black,
                      width: 22,
                      height: 22,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      LocaleKeys.orders.tr(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 8,),
          Expanded(
            child: InkWell(
              onTap: (){
                widget.onTapFavorite();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: GREY_LIGHT_COLOR, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Image.asset(
                      Assets.profileDiscount, color: Colors.black,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      "Chegirmalar",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
