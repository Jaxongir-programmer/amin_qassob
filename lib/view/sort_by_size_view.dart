import 'package:flutter/material.dart';

import '../model/size_model.dart';

class SortBySizeView extends StatefulWidget{
  final SizeModel item;
  SortBySizeView(this.item);
  @override
  State<StatefulWidget> createState() {

    return SortBySizeViewState();
  }
  
}
class SortBySizeViewState extends State<SortBySizeView>{
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: widget.item.checked ? Colors.blue : Colors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ]
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.item.size_Name,
              style: TextStyle(
                  color: widget.item.checked ? Colors.white : Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
  
}