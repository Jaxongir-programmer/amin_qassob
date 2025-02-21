import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/message_model.dart';
import '../utils/utils.dart';
import 'custom_views.dart';


class MessageView extends StatefulWidget {
  final Color color;
  MessageModel item;

  MessageView(this.item,{Key? key, required this.color })
      : super(key: key);

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (){
        showModalSheet();
      },
      child: Card(
        elevation: 5,
        // shadowColor: widget.color,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: widget.color, width: 0.6),
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.white,
        margin: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 8),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
          child: Container(
            // decoration: BoxDecoration(
            //     color: widget.color.withAlpha(20),
            //     border: Border.all(color: widget.color),),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomViews.buildNetworkImage(widget.item.imagesName, height: 120),
                // Image.asset("assets/images/axirin_splash.png",fit: BoxFit.contain),
                const SizedBox(height: 12,),
                Text(
                  widget.item.message,
                  maxLines: 5,
                  style: const TextStyle(fontSize: 18,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis, ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(widget.item.date,
                    style: const TextStyle(fontSize: 14,
                      color: Colors.grey
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void showModalSheet(){
    var size = MediaQuery.of(context).size;
    showMyBottomSheet(context,
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    widget.item.date,
                    style: const TextStyle(color: Colors.black,fontSize: 14, overflow: TextOverflow.ellipsis),
                  ),
                ),
                const Divider(),
                CustomViews.buildNetworkImage(widget.item.imagesName, height: 140),
                const SizedBox(height: 12,),
                Text(
                  widget.item.message,
                  style: const TextStyle(color: Colors.black,fontSize: 16, ),
                ),
              ]),
        ));
  }
}
