import 'dart:async';


import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../model/address_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/pref_utils.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  List<Marker> markers = [];
  LatLng? selectedPosition;
  LatLng? currentPosition;
  final Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    getLocation();
    // PrefUtils.setLocation(AddressModel(0.0, 0.0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: COLOR_PRIMARY,
    //   statusBarBrightness: Brightness.dark,
    // ));
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: GoogleMap(
                  gestureRecognizers:
                  <Factory<OneSequenceGestureRecognizer>>{
                    Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                    ),
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: true,
                  markers: Set.of(markers),
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                  onTap: (position) async {
                    setState(() {
                      selectedPosition = position;
                      markers.clear();
                      markers.add(Marker(
                          markerId: const MarkerId("1"),
                          position: position));
                    });
                  },
                  initialCameraPosition: CameraPosition(
                      target: selectedPosition != null
                          ? LatLng(selectedPosition!.latitude,
                          selectedPosition!.longitude)
                          : currentPosition != null
                          ? LatLng(currentPosition!.latitude,
                          currentPosition!.longitude)
                          : const LatLng(41.2995, 69.2401),
                      zoom: 12),
                ),
              ),
              const Divider(),

              Center(child: Text("${selectedPosition?.latitude??0.0}  ${selectedPosition?.longitude??0.0}")),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 4, bottom: 8),
                child: ElevatedButton(
                    onPressed: () {
                      if (selectedPosition == null) {
                        ScaffoldMessenger.maybeOf(context)
                            ?.showSnackBar(SnackBar(
                            content: Text(
                                "${"Iltimos, manzilni tanlang"} !")));
                        return;
                      }
                      Navigator.pop(context, AddressModel(selectedPosition?.latitude??0.0, selectedPosition?.longitude??0.0));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: COLOR_PRIMARY_DARK, backgroundColor: COLOR_PRIMARY,
                      shadowColor: COLOR_PRIMARY_DARK,
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                    ),
                    child: Text(
                      "Tanlash",
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getLocation() async {
    try {
      await Geolocator.requestPermission();
      final location = await Geolocator.getCurrentPosition();
      setState(() {
        currentPosition = LatLng(location.latitude, location.longitude);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
