import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/lang.g.dart';
import 'package:amin_qassob/utils/pref_utils.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:amin_qassob/view/custom_views.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ficonsax/ficonsax.dart';

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../generated/assets.dart';
import '../model/product_model.dart';
import '../provider/providers.dart';
import '../screen/auth/login_screen.dart';
import '../screen/main/product_detail/detail_screen.dart';
import '../utils/app_colors.dart';

class ProductsItemView extends StatefulWidget {
  final ProductModel item;

  ProductsItemView({required this.item, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProductsItemViewState();
  }
}

class ProductsItemViewState extends State<ProductsItemView> {
  double addCount = 0;

  @override
  void initState() {
    // addCount = widget.item.sht;
    addCount = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(builder: (context, provider, child) {
      // widget.item.cartPrice = widget.item.price - (widget.item.price * (widget.item.skidka ?? 0) / 100);
      widget.item.cartPrice = widget.item.price;
      widget.item.cartCount = provider.productCount(widget.item.id);
      return InkWell(
        onTap: () {
          clearFocus(context);
          startScreenF(
              context,
              ShopDetailScreen(
                item: widget.item,
              ));
        },
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.only(right: 6, left: 6),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
              color: WHITE,
              border: Border.all(color: BACKGROUND_COLOR),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Container(
                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            CustomViews.buildNetworkImage(widget.item.photos.isNotEmpty?widget.item.photos[0]??"":"",
                                fit: BoxFit.cover, width: getScreenWidth(context), height: 120),
                            if (widget.item.limit <= 0)
                              Container(
                                width: getScreenWidth(context),
                                height: 120,
                                alignment: Alignment.center,
                                decoration:
                                    BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(6)),
                                child: const Text(
                                  "Hozirda mavjud emas !",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // if (widget.item.status != "")
                    //   Positioned(
                    //       bottom: 0,
                    //       left: 0,
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    //         decoration: BoxDecoration(
                    //             color: setColor(widget.item.status_color ?? ""),
                    //             borderRadius: BorderRadius.circular(8)),
                    //         child: Text(
                    //           widget.item.status ?? "Yangilik",
                    //           style: const TextStyle(fontSize: 12, color: Colors.white),
                    //         ),
                    //       )),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              provider.addToFavorite(widget.item, provider.isFavorite(widget.item.id));
                            },
                            child: CircleAvatar(
                              backgroundColor: WHITE.withAlpha(180),
                              maxRadius: 15,
                              child: Icon(
                                  provider.isFavorite(widget.item.id) ? IconsaxBold.heart : IconsaxOutline.heart,
                                  color: Colors.red,
                                  size: 20),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                            fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          color: BLACK
                        )),
                    // Text(widget.item.unit, style: const TextStyle(color: PRIMARY_COLOR, fontSize: 12)),
                    // if (widget.item.skidka != 0 && widget.item.skidka != null)
                    //   Row(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    //         decoration: const BoxDecoration(
                    //           borderRadius: BorderRadius.all(Radius.circular(6)),
                    //           color: Colors.yellow,
                    //         ),
                    //         child: Text(
                    //           "-${widget.item.skidka} %",
                    //           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 8,
                    //       ),
                    //       Text(
                    //         "${widget.item.price.formattedAmountString()} ₩",
                    //         style: const TextStyle(fontSize: 13, decoration: TextDecoration.lineThrough),
                    //       )
                    //     ],
                    //   ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: PRIMARY_COLOR.withAlpha(200),
                          borderRadius:  BorderRadius.circular(6)
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Assets.profileWallet2x,
                            width: 20,
                            height: 20,
                            color: WHITE,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "${widget.item.cartPrice.formattedAmountString()} ₩",
                            style: const TextStyle(color: WHITE, fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            "${" "}(${widget.item.unit})",
                            style: const TextStyle(color: GREY_LIGHT_COLOR, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  if (PrefUtils.getToken() == "") {
                    startScreenF(context, LoginScreen());
                  } else if (provider.productCount(widget.item.id) == 0) {
                    setState(() {
                      widget.item.cartCount += addCount;

                      if (widget.item.cartCount > widget.item.limit) {
                        showWarning(
                            context, "Omborda mahsulot kam!.\n Qoldiq : ${widget.item.limit.formattedAmountString()} dona");
                        widget.item.cartCount -= addCount;
                      } else {
                        provider.addToCart = widget.item;
                      }
                    });
                  }
                },
                child: Container(
                    width: getScreenWidth(context),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: provider.productCount(widget.item.id) == 0 ? 8 : 6),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.8))),
                    child: (provider.productCount(widget.item.id) == 0)
                        ? Text(
                            LocaleKeys.add_2_cart.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                                  child: Icon(CupertinoIcons.minus),
                                ),
                                onTap: () {
                                  setState(() {
                                    widget.item.cartCount -= addCount;
                                    if (widget.item.cartCount > 0) {
                                      provider.addToCart = widget.item;
                                    } else {
                                      widget.item.cartCount = 0;

                                      provider.addToCart = widget.item;
                                    }
                                  });
                                },
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      provider.productCount(widget.item.id) < 1.0
                                          ? "0"
                                          : provider.productCount(widget.item.id).formattedAmountString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(widget.item.unit,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: PRIMARY_COLOR,
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    widget.item.cartCount += addCount;

                                    if (widget.item.cartCount > widget.item.limit) {
                                      showWarning(context,
                                          "Omborda mahsulot kam!.\n Qoldiq : ${widget.item.limit.formattedAmountString()} dona");
                                      widget.item.cartCount -= addCount;
                                    } else {
                                      provider.addToCart = widget.item;
                                    }
                                  });
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                                  child: Icon(CupertinoIcons.plus),
                                ),
                              ),
                            ],
                          )),
              )
            ],
          ),
        ),
      );
    });
  }
}
