import 'package:amin_qassob/model/map_item_model.dart';
import 'package:get/get_utils/get_utils.dart';

import '../model/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../utils/pref_utils.dart';

class Providers extends ChangeNotifier {
  Providers();

  Box<ProductModel> box = Hive.box<ProductModel>('products_table');
  var index = 0;
  var message_count = 0;


  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void setIndex(int count) {
    index = count;
    notifyListeners();
  }

  int getIndex() {
    return index;
  }

  void setBadgeCount(int count){
    message_count = count;
    notifyListeners();
  }

  int getBadgeCount(){
    return message_count;
  }

  //===========================Products===================================

  set addToCart(ProductModel item) {
    print("CartCOUNT - ${item.cartCount}");
    PrefUtils.addToCart(item);
    notifyListeners();
  }

  List<ProductModel> get getCartList {
    return PrefUtils.getCartList();
  }

  double productCount(String id) {
    ProductModel? item = getCartList.firstWhereOrNull((element) => element.id == id);
    double count = (item != null) ? item.cartCount : 0;
    return count;
  }

  Future<void> clearCart() async {
    await PrefUtils.clearCart();
    notifyListeners();
  }

  double get cartSumma {
    double summa = 0;
    for (var element in getCartList) {
      summa += (element.cartCount * element.cartPrice );
    }
    return summa;
  }

  double getTotalCashback(){
    var totalCash = 0.0;
    for (var it in PrefUtils.getCartList()) {
      totalCash += it.cartCashback;
    }
    return totalCash;
  }


  //===========================FAVORITES===================================//

  void addToFavorite(ProductModel item, bool isFavorite) {
    PrefUtils.addToFavorite(item, isFavorite);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteList {
    return PrefUtils.getFavoriteList();
  }

  bool isFavorite(String tovarId) {
    return getFavoriteList.where((element) => element.id == tovarId).isNotEmpty;
  }

//===========================MAP ITEMS===================================//

  set addNewAddress(MapItemModel? item) {
    PrefUtils.setNewAddress(item);
    notifyListeners();
  }

  void deleteAddress(MapItemModel item) {
    PrefUtils.deleteAddress(item);
    notifyListeners();
  }

  List<MapItemModel> get getAdresList {
    return PrefUtils.getAddressList();
  }

  MapItemModel? get getSelectAdres {
    return getAdresList.firstWhereOrNull((element) => element.isChecked == true);
  }

  set setActiveAdress(MapItemModel? item) {
   PrefUtils.setActiveAdres(item);
   notifyListeners();
  }
}
