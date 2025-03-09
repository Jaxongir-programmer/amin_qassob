import 'package:amin_qassob/utils/utils.dart';
// import 'package:easy_localization/easy_localization.dart';

import '../extensions/extensions.dart';
import '../model/basket_model.dart';
import '../model/product_model.dart';
import '../utils/app_colors.dart';
import '../utils/pref_utils.dart';
import '../view/custom_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/providers.dart';

class CartItemLayout extends StatefulWidget {
  ProductModel item;

  CartItemLayout(this.item, {Key? key}) : super(key: key);

  @override
  State<CartItemLayout> createState() => _CartItemLayoutState();
}

class _CartItemLayoutState extends State<CartItemLayout> {
  var cashback = 0.0;

  double addCount = 0;

  @override
  void initState() {
    // addCount = widget.item.sht;
    addCount = 1;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Providers>(builder: (context, provider, child) {
      var totalPrice = widget.item.cartCount * widget.item.cartPrice;
      widget.item.cartCount = provider.productCount(widget.item.id);
      return Container(
        margin: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 4, blurStyle: BlurStyle.outer)],
            color: Colors.white,
            border: Border.all(color: GREY_LIGHT_COLOR),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomViews.buildNetworkImage(
                widget.item.image,
                width: 95,
                height: 110,
                fit: BoxFit.contain
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: widget.item.title, style: const TextStyle(fontSize: 14)),
                            TextSpan(
                                text: " ${widget.item.unit}",
                                style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              widget.item.cartCount = 0;
                              provider.addToCart = widget.item;
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: RED_COLOR,
                            size: 24,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Jami: ",
                        style: TextStyle(color: Colors.black),
                      ),
                      Text(
                        "${(totalPrice).formattedAmountString()}so'm",
                        style: const TextStyle(color: PRIMARY_COLOR),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                            widget.item.cartPrice.formattedAmountString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          )),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade100, width: 1)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.item.cartCount-=addCount;
                                  if (widget.item.cartCount > 0) {
                                    cashback =
                                        widget.item.cartCount * widget.item.cartPrice;
                                  } else {
                                    widget.item.cartCount = 0.0;
                                  }
                                });
                                provider.addToCart = widget.item;
                              },
                              child: Container(
                                height: 30,
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
                                ),
                                child: const Center(
                                    child: Text(
                                  "-",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                )),
                              ),
                            ),
                            Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Row(
                                children: [
                                  Text(
                                    widget.item.cartCount.formattedAmountString(),
                                    style: const TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.item.unit,
                                    style: const TextStyle(color: GREY_TEXT_COLOR, fontSize: 12),
                                  ),
                                ],
                              ),
                            )),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  widget.item.cartCount+=addCount;
                                  if (widget.item.cartCount > widget.item.limit) {
                                    showWarning(context,
                                        "${"Ombordagidan mahsulot kam!. Qoldiq"}: ${widget.item.limit.formattedAmountString()} dona");
                                    widget.item.cartCount-=addCount;
                                  } else {
                                    cashback =
                                        widget.item.cartCount * widget.item.cartPrice;
                                  }
                                });
                                provider.addToCart = widget.item;
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                                ),
                                child: const Center(
                                    child: Text(
                                  "+",
                                  style: TextStyle(color: Colors.black, fontSize: 20),
                                )),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (widget.item.cartCount > widget.item.limit)
                    Row(
                      children: [
                        const Text("Ombordagidan mahsulot kam!. Qoldiq", style: TextStyle(fontSize: 14, color: RED_COLOR)),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          "${widget.item.limit}",
                          style: const TextStyle(fontSize: 14, color: RED_COLOR),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.item.unit,
                          style: const TextStyle(color: RED_COLOR, fontSize: 12),
                        ),
                      ],
                    )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
