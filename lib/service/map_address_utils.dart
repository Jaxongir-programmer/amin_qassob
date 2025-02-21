// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// Future<Placemark?> getPlaceMarkFromLatLng(LatLng? position) async {
//   List<Placemark> placemarks = [];
//   if (position != null) {
//     placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
//   }
//   return placemarks.firstOrNull;
// }
//
// Future<LatLng?> getCoordinateFromAddress(String? address) async {
//   List<LatLng> locations = [];
//   if (address != null) {
//     List<Location> loc = await locationFromAddress(address);
//     locations = loc.map((e) => LatLng(e.latitude, e.longitude)).toList();
//   }
//   return locations.firstOrNull;
// }

// String placemarkAddressFullName(Placemark address) {
//   var country = _editName(address.country ?? "");
//   var administrativeArea = _editName(address.administrativeArea ?? "");
//   var subAdministrativeArea = _editName(address.subAdministrativeArea ?? "");
//   var locality = _editName(address.locality ?? "");
//   var subLocality = _editName(address.subLocality ?? "");
//   var thoroughfare = _editName(address.thoroughfare ?? "");
//   var subThoroughfare = _editName(address.subThoroughfare ?? "");
//   var street = _editName(address.street ?? "");
//
//   var name = subAdministrativeArea + locality + subLocality + thoroughfare + subThoroughfare;
//   return name.isNotEmpty
//       ? name
//       : administrativeArea.isNotEmpty
//           ? administrativeArea
//           : "Joy nomi aniqlanmadi!";
//
// //   Name: 75,
// //   Street: 75 Yusuf Hos Hojib ko'chasi,
// //   ISO Country Code: UZ,
// //   Country: Uzbekistan,
// //   Postal code: 100087,
// //   Administrative area: Toshkent,
// //   Subadministrative area: ,
// //   Locality: Tashkent,
// //   Sublocality: Yakkasaroy tumani,
// //   Thoroughfare: Yusuf Hos Hojib ko'chasi,
// //   Subthoroughfare: 75
// }
//
// String _editName(String value) {
//   if (value.isNotEmpty && value != "Unnamed Road") {
//     return "$value, ";
//   }
//   return "";
// }
//
// Future<String?> getPlaceMarkFromYandex(Point? position) async {
//   // SearchResultWithSession? resultWithSession;
//   // if (position != null) {
//   //   resultWithSession = YandexSearch.searchByPoint(
//   //       point: position, searchOptions: const SearchOptions(searchType: SearchType.none, geometry: false));
//   // }
//   //
//   // var address = (await resultWithSession?.result)?.items?.first.toponymMetadata?.address.formattedAddress;
//   // return address;
// }