import 'package:amin_qassob/extensions/extensions.dart';
import 'package:amin_qassob/utils/app_colors.dart';
import 'package:amin_qassob/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ficonsax/ficonsax.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lang.g.dart';
import '../model/product_model.dart';
import '../provider/providers.dart';
import '../screen/auth/login_screen.dart';
import '../screen/main/product_detail/detail_screen.dart';
import '../utils/pref_utils.dart';

class TopProductItemView extends StatefulWidget {
  ProductModel item;

  TopProductItemView({Key? key, required this.item}) : super(key: key);

  @override
  State<TopProductItemView> createState() => _TopProductItemViewState();
}

class _TopProductItemViewState extends State<TopProductItemView> {
  var borderRadius = const BorderRadius.all(Radius.circular(8));
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
      widget.item.cartPrice = widget.item.price;
      widget.item.cartCount = provider.productCount(widget.item.id);
      return InkWell(
        borderRadius: borderRadius,
        onTap: () {
          startScreenF(context, ShopDetailScreen(item: widget.item));
        },
        child: Container(
          width: 145,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
              color: WHITE,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.7))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                // width: 123,
                child: Stack(
                  children: [
                    asCachedNetworkImage(widget.item.photos.isNotEmpty ? widget.item.photos[0] ?? "" : widget.item.image,
                        fit: BoxFit.cover, width: 133, height: 80),
                    // if (widget.item.status != "" && widget.item.status != null)
                    //   Positioned(
                    //       bottom: 0,
                    //       left: 0,
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    //         decoration: BoxDecoration(
                    //             color: setColor(widget.item.status_color ?? ""),
                    //             borderRadius: BorderRadius.circular(8)),
                    //         child: Text(
                    //           widget.item.status ?? "",
                    //           style: const TextStyle(fontSize: 10, color: Colors.white),
                    //         ),
                    //       )),
                    if (widget.item.limit <= 0)
                      Positioned(
                          child: Container(
                        width: 133,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          "Hozirda mavjud emas !",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      )),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                          onTap: () {
                            provider.addToFavorite(widget.item, provider.isFavorite(widget.item.id));
                          },
                          child: CircleAvatar(
                            backgroundColor: WHITE.withAlpha(180),
                            maxRadius: 15,
                            child: Icon(provider.isFavorite(widget.item.id) ? IconsaxBold.heart : IconsaxOutline.heart,
                                size: 20, color: Colors.red),
                          )),
                    ),
                    if (widget.item.discount != null && widget.item.discount != 0)
                    Positioned(
                      top: 0,
                      left: 0,
                      child: CircleAvatar(
                        backgroundColor: WHITE.withAlpha(180),
                        maxRadius: 15,
                        child: Icon(IconsaxOutline.discount_circle,
                            size: 20, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${widget.item.title}\n",
                maxLines: (widget.item.discount != null && widget.item.discount != 0)?1:2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: BLACK,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  // maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Text(widget.item.unit, style: const TextStyle(color: PRIMARY_COLOR, fontSize: 12)),
              // const SizedBox(
              //   height: 4,
              // ),
              if (widget.item.discount != null && widget.item.discount != 0)
              Text(
                "${widget.item.discount?.formattedAmountString()}₩",
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: RED, decoration: TextDecoration.lineThrough, decorationColor: GREY),
              ),
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
                      width: 2,
                    ),
                    Text(
                      "${widget.item.price.formattedAmountString()}₩",
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: WHITE),
                    ),
                    Text(
                      " (${widget.item.unit})",
                      style: const TextStyle(fontSize: 13, color: GREY_LIGHT_COLOR),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 4),
              InkWell(
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
                  height: 30,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.8))),
                  child: (provider.productCount(widget.item.id) == 0)
                      ? Text(
                    LocaleKeys.add_2_cart.tr(),
                          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
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
                                child: const Icon(
                                  Icons.remove,
                                  size: 23,
                                )),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: provider.productCount(widget.item.id) < 1.0
                                        ? "0"
                                        : provider.productCount(widget.item.id).formattedAmountString(),
                                    style: const TextStyle(
                                      color: Color(0xFF212121),
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextSpan(
                                    text: widget.item.unit,
                                    style: const TextStyle(color: GREY, fontSize: 14),
                                  ),
                                ],
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                                child: const Icon(
                                  Icons.add,
                                  size: 23,
                                )),
                          ],
                        ),
                      ),
              )
            ],
          ),
        ),
      );
    });
  }
}
