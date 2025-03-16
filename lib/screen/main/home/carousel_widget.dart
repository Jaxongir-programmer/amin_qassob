import 'package:amin_qassob/model/offer_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../view/carousel_item_view.dart';

class CarouselWidget extends StatefulWidget {
  List<OfferModel> photosList = [];
  CarouselWidget({Key? key, required this.photosList}) : super(key: key);

  @override
  _CarouselWidgetState createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.photosList.length,
        // itemCount: 5,
        itemBuilder: (context, index, realIndex) {
          return CarouselItemView(
            onClick: () {
              launchURL(widget.photosList[index].link ?? '');
            },
            index: index,
            item: widget.photosList[index],
            // item: Constants.photosList[index],
          );
        },
        options: CarouselOptions(
            height: 190,
            aspectRatio: 16 / 9,
            viewportFraction: 0.85,
            initialPage: 0,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            autoPlayCurve: Curves.easeInSine,
            //easeInSine,//fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
            onPageChanged: (v, a) {
              setState(() {
                _currentIndex = v;
              });
            }));
  }
  Future<void> launchURL(String link) async {
    final Uri url = Uri.parse('https://example.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Link ochib bo‘lmadi: $url';
    }
  }
}
