import 'package:flutter/material.dart';

import '../../utils/pref_utils.dart';

class OffertaScreen extends StatefulWidget {
  const OffertaScreen({Key? key}) : super(key: key);

  @override
  State<OffertaScreen> createState() => _OffertaScreenState();
}

class _OffertaScreenState extends State<OffertaScreen> {
  @override
  Widget build(BuildContext context) {
    print("OfferScreen");
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(title: Text("Ommaviy Offerta")),
            body: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(PrefUtils.getPublicOffer(), style: TextStyle(fontSize: 16)),
                ),
              ],
            ))
      ],
    );
  }
}
