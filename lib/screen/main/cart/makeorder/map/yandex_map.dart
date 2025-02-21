import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:map_picker/map_picker.dart';
import 'package:provider/provider.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../generated/assets.dart';
import '../../../../../model/map_item_model.dart';
import '../../../../../provider/providers.dart';
import '../../../../../service/location_yandex_service.dart';
import '../../../../../service/map_address_utils.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';
import '../../../../../utils/pref_utils.dart';
import '../../../../../utils/utils.dart';
import '../../../../../view/custom_views.dart';

// class YandexMapScreen2 extends StatefulWidget {
//   final MapItemModel? itemMap;
//
//   const YandexMapScreen2({Key? key, this.itemMap}) : super(key: key);
//
//   @override
//   State<YandexMapScreen2> createState() => _YandexMapScreen2State();
// }
//
// class _YandexMapScreen2State extends State<YandexMapScreen2> {
//   TextEditingController reNameController = TextEditingController(text: "Uy");
//
//   late Point placeLocation;
//   final double _zoomSize = 16.0;
//
//   late Point _draggedLatLng;
//   final Completer<YandexMapController> _yandexMapController = Completer();
//
//   MapPickerController mapPickerController = MapPickerController();
//   List<MapObject> mapObjects = [];
//   BitmapDescriptor? locationIcon;
//
//   @override
//   void initState() {
//     setCustomMarker();
//     Point latlongs = widget.itemMap != null
//         ? Point(latitude: widget.itemMap!.lat, longitude: widget.itemMap!.long)
//         : defaultLocationYandex;
//     _draggedLatLng = latlongs;
//     placeLocation = latlongs;
//     super.initState();
//   }
//
//   void setCustomMarker() {
//     getBytesFromAsset(Assets.imagesLocationIcon, 130)
//         .then((value) => locationIcon = BitmapDescriptor.fromBytes(value!));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Address")),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 MapPicker(
//                     mapPickerController: mapPickerController,
//                     showDot: true,
//                     iconWidget: true ? SvgPicture.asset("assets/images/location_icon.svg", height: 60) : null,
//                     child: YandexMap(
//                       tiltGesturesEnabled: false,
//                       onMapCreated: (YandexMapController controller) async {
//                         _yandexMapController.complete(controller);
//
//                         controller.moveCamera(
//                             CameraUpdate.newCameraPosition(CameraPosition(target: placeLocation, zoom: _zoomSize)));
//                         if (placeLocation == defaultLocationYandex) {
//                           LocationYandexService().gotoUserCurrentPosition(context, _yandexMapController);
//                         }
//                       },
//                       mapType: MapType.vector,
//                       onMapTap: (location) async {},
//                       onUserLocationAdded: (view) {
//                         return null;
//                       },
//                       onCameraPositionChanged: (position, update, check) async {
//                         if (check) {
//                           setState(() {
//                             _draggedLatLng = position.target;
//                           });
//                         }
//                         if (!check) {
//                           mapPickerController.mapMoving!();
//                         } else {
//                           mapPickerController.mapFinishedMoving!();
//                         }
//                       },
//                     )),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: InkWell(
//                     onTap: () {
//                       LocationYandexService().gotoUserCurrentPosition(context, _yandexMapController);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 24),
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(color: COLOR_PRIMARY, borderRadius: BorderRadius.circular(50)),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(Icons.my_location, color: Colors.white,),
//                           SizedBox(width: 10),
//                           Text("Mening Joylashuvim", style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500))
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             color: Colors.grey.shade200,
//             child: ElevatedButton(
//                 style: ButtonStyle(
//                     backgroundColor: MaterialStatePropertyAll(
//                         calculateDistance(_draggedLatLng!.latitude, _draggedLatLng!.longitude) ? PRIMARY_COLOR : GREY)),
//                 onPressed: () async {
//                   if (calculateDistance(_draggedLatLng!.latitude, _draggedLatLng!.longitude)) {
//                     // MapItemModel? item = await showAnimatedBlinkDialog(context,
//                     //     child: Wrap(children: [_showInfo(context, _draggedLatLng!)]));
//                     MapItemModel? item = await showMyBottomSheet(context, _showInfo(context, _draggedLatLng!));
//                     if (item != null) {
//                       Navigator.pop(context, item);
//                     }
//                   }
//                 },
//                 child: Text(
//                     calculateDistance(_draggedLatLng!.latitude, _draggedLatLng!.longitude)
//                         ? "Tasdiqlash"
//                         : "Yetkazish hududidan tashqarida",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white))),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _showInfo(BuildContext context, Point position) {
//     final provider = Provider.of<Providers>(context, listen: false);
//     bool isActive = false;
//     MapItemModel? mapAddress;
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SizedBox(
//           height: 12,
//         ),
//         const Text(
//           "Joylashuv Malumotlari",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         const SizedBox(height: 16),
//         FutureBuilder(
//           future: getPlaceMarkFromYandex(Point(latitude: position.latitude, longitude: position.longitude)),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               isActive = false;
//               return Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [shimmerColors(child: skeleton(height: 44))]);
//             }
//             if (snapshot.connectionState == ConnectionState.done) isActive = true;
//             double newId = provider.getAdresList.isNotEmpty ? provider.getAdresList.last.id + 1 : 0;
//             String address = snapshot.data.toString();
//             mapAddress = MapItemModel(newId, address, reNameController.text, position.latitude, position.longitude);
//             return CustomViews.buildText("", address);
//           },
//         ),
//         CustomViews.buildTextField("", "Misol:Uy", controller: reNameController),
//         const SizedBox(height: 30),
//         ElevatedButton(
//             style: const ButtonStyle(
//               backgroundColor: MaterialStatePropertyAll(COLOR_PRIMARY),
//             ),
//             onPressed: () {
//               if (calculateDistance(_draggedLatLng!.latitude, _draggedLatLng!.longitude)) {
//                 mapAddress?.reName = reNameController.text;
//                 provider.addNewAddress = mapAddress;
//                 provider.setActiveAdress = mapAddress;
//                 Navigator.pop(context);
//                 Navigator.pop(context);
//               }
//             },
//             child: Text(
//                 calculateDistance(_draggedLatLng!.latitude, _draggedLatLng!.longitude)
//                     ? "Tasdiqlash"
//                     : "Yetkazish hududidan tashqarida",
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)))
//       ],
//     );
//   }
//
//   bool calculateDistance(my_lat, my_lon) {
//     // qoqn sentridan boshlab radiusni xisoblaydi. agar xizmat korsatish hududida bolmasa false qaytaradi
//     double radius = 0;
//     double qoqon_lat = 40.538809199846185;
//     double qoqon_lon = 70.93768802572866;
//     var p = 0.017453292519943295;
//     var c = cos;
//     var a = 0.5 -
//         c((qoqon_lat - my_lat) * p) / 2 +
//         c(my_lat * p) * c(qoqon_lat * p) * (1 - c((qoqon_lon - my_lon) * p)) / 2;
//     radius = 12742 * asin(sqrt(a));
//
//     return radius > (PrefUtils.getUser()?.orderRadius ?? 10) ? false : true;
//   }
// }
