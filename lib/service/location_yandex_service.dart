import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../utils/utils.dart';


// class LocationYandexService {
//
//   String? _currentAddress;
//   // Position? _currentPosition;
//
//   Future<Point> gotoUserCurrentPosition(
//       BuildContext context, Completer<YandexMapController>? yandexMapController) async {
//     Point currentPosition = await _initPermission(context);
//     if (yandexMapController != null) {
//       goToSpecificPosition(
//           Point(latitude: currentPosition.latitude, longitude: currentPosition.longitude), yandexMapController);
//     }
//     return Point(latitude: currentPosition.latitude, longitude: currentPosition.longitude);
//   }
//
//   Future goToSpecificPosition(Point position, Completer<YandexMapController> yandexMapController,
//       {double zoom = 16}) async {
//     YandexMapController mapController = await yandexMapController.future;
//     mapController.moveCamera(
//       animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
//       CameraUpdate.newCameraPosition(CameraPosition(target: position, zoom: zoom)),
//     );
//   }
//
//   Future<Point> _initPermission(BuildContext context) async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       // if (permission == LocationPermission.denied) {
//         // ignore: use_build_context_synchronously
//         showError(context, "Joylashuv ruxsatlari rad etilgan");
//         return Future.error("Joylashuv ruxsatlari rad etilgan");
//       // }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       // ignore: use_build_context_synchronously
//       showError(context, "Joylashuvga ruxsatnomalar butunlay rad etilgan, biz ruxsat so‘ray olmaymiz");
//       return Future.error("Joylashuvga ruxsatnomalar butunlay rad etilgan, biz ruxsat so‘ray olmaymiz");
//     }
//
//     var aa = await Geolocator.getCurrentPosition();
//     return Point(latitude: aa.latitude, longitude: aa.longitude);
//   }
//
//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       //     content: Text(
//       //         'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //     const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       //     content: Text(
//       //         'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }
//
//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//         _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       // setState(() {
//         _currentAddress =
//         '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
//       // });
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
//
//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();
//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//        _currentPosition = position;
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }
// }
