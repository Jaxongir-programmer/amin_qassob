import '../extensions/extensions.dart';
import '../model/order_product_model.dart';
import 'package:flutter/material.dart';

class OrderProductItemView extends StatefulWidget {
  OrderProductModel item;

  OrderProductItemView(this.item,{Key? key}) : super(key: key);

  @override
  _OrderProductItemViewState createState() => _OrderProductItemViewState();
}

class _OrderProductItemViewState extends State<OrderProductItemView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text(widget.item.name??"", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)),
            Expanded(
              child: Column(
                
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(widget.item.count.toString(), style: TextStyle(fontSize: 12),)),
                      Expanded(child: Text((widget.item.count * widget.item.price).formattedAmountString(),style: TextStyle(fontSize: 12),))
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Expanded(child: Text("${widget.item.Keshback_foiz}", style: TextStyle(fontSize: 12),)),
                  //     Expanded(child: Text("${widget.item.Keshback_summa}", style: TextStyle(fontSize: 12),))
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
        Divider()
      ],
    );
  }
}
