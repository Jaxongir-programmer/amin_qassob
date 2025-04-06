// import 'package:easy_localization/easy_localization.dart';

import 'package:amin_qassob/lang.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../extensions/extensions.dart';
import '../model/order_model.dart';
import '../provider/providers.dart';
import '../screen/main/cart/makeorder/success/success_screen.dart';
import '../utils/app_colors.dart';
import '../utils/pref_utils.dart';
import '../utils/utils.dart';
import '../view/order_product_item_view.dart';
import 'package:flutter/material.dart';

class OrderItemView extends StatefulWidget {
  OrderModel item;

  OrderItemView(this.item, {Key? key}) : super(key: key);

  @override
  _OrderItemViewState createState() => _OrderItemViewState();
}

class _OrderItemViewState extends State<OrderItemView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showOrdersSheet();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.shopping_bag_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(
                    "Trek raqami",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Expanded(child: Text("${widget.item.id}")),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.monetization_on_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(child: Text(LocaleKeys.total_amount.tr())),
                  Expanded(
                    child: Text(
                      "${widget.item.total_price.formattedAmountString()} ₩",
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   height: 8,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   child: Row(
            //     children: [
            //       const Icon(Icons.card_giftcard, size: 18, color: Colors.grey,),
            //       const SizedBox(width: 8,),
            //       Expanded(child: Text("${"Keshbek"}:")),
            //       Expanded(child: Text("${widget.item.Kashback_Itog} UZS")),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  const Icon(
                    Icons.date_range_outlined,
                    size: 18,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(child: Text("${"Vaqti"}:")),
                  Expanded(child: Text(widget.item.created.substring(0, 16))),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
                onPressed: () {
                  if (!widget.item.paid) {
                    startScreenF(
                        context,
                        SuccessScreen(
                          orderId: widget.item.id,
                          total_pay: widget.item.total_price + PrefUtils.getUser()!.deliver_summa,
                        ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: PRIMARY_COLOR,
                  backgroundColor: widget.item.paid ? Colors.green : PRIMARY_COLOR,
                  shadowColor: PRIMARY_COLOR,
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
                child: Text(
                  widget.item.paid
                      ? "To'lov qilingan".toUpperCase()
                      : "To'lov qilinmagan".toUpperCase(),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ))
          ],
        ),
      ),
    );
  }

  void showOrdersSheet() {
    showMyBottomSheet(
      context,
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Trek raqami",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
                    Expanded(child: Text("${widget.item.id}")),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(child: Text("Umumiy summa")),
                    Expanded(
                      child: Text(
                        widget.item.total_price.formattedAmountString(),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: Row(
              //     children: [
              //       Expanded(child: Text("Keshbek")),
              //       Expanded(child: Text("${widget.item.Kashback_Itog}")),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(child: Text("date" + ": ")),
                    Expanded(child: Text("${widget.item.created}")),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 8,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   child: Row(
              //     children: [
              //       Expanded(child: Text("order_state".tr())),
              //       Expanded(
              //           child: Text(
              //         getStatusTitle(widget.item.status),
              //         style: TextStyle(color: getPrioritetColor(widget.item.status)),
              //       )),
              //     ],
              //   ),
              // ),
              Divider(),
              ListView.builder(
                  itemCount: widget.item.products.length,
                  shrinkWrap: true,
                  itemBuilder: (_, position) {
                    var item = widget.item.products[position];
                    return OrderProductItemView(item);
                  })
            ],
          ),
        ],
      ),
    );
  }

  String getStatusTitle(OrderStatus? statusEnum) {
    switch (statusEnum!) {
      case OrderStatus.WAITING:
        return "Kutilmoqda";
      case OrderStatus.ACCEPTED:
        return "Qabul qilindi";
      case OrderStatus.COMPLETED:
        return "Yakunlandi";
      case OrderStatus.CANCELED:
        return "Rad etildi";
    }
    return "Yo'q";
  }

  Color getPrioritetColor(OrderStatus? priority) {
    switch (priority!) {
      case OrderStatus.WAITING:
        return STATUS_WAITING;
      case OrderStatus.ACCEPTED:
        return STATUS_ACCEPTED;
      case OrderStatus.COMPLETED:
        return STATUS_COMPLETED;
      case OrderStatus.CANCELED:
        return STATUS_CANCELED;
    }
    return PRIMARY_COLOR;
  }
}
