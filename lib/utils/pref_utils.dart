import 'dart:convert';

import 'package:amin_qassob/model/map_item_model.dart';
import 'package:amin_qassob/model/my_address_model.dart';
import 'package:amin_qassob/model/phone_number_model.dart';

import '../model/address_model.dart';
import '../model/basket_model.dart';
import '../model/category_model.dart';
import '../model/filter_brand_model.dart';
import '../model/product_model.dart';
import '../model/user_info_model.dart';
import 'package:event_bus/event_bus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/bdm_items_model.dart';
import '../model/event_model.dart';
import 'constants.dart';

class PrefUtils {

  static const PREF_BDM_ITEMS = "bdm_items";
  static const PREF_SELECTED_BRANCH = "selected_branch";
  static const PREF_FAVORITES = "favorites";
  static const ADMIN_PHONES = "ADMIN_PHONES";
  static const PREF_ADDRESS = "PREF_ADDRESS";
  static const PREF_BASE_URL = "base_url";
  static const PREF_BASE_IMAGE_URL = "base_image_url";
  static const PREF_FCM_TOKEN = "fcm_token";
  static const PREF_TOKEN = "token";
  static const PREF_OFFERTA = "PREF_OFFERTA";
  static const PREF_CATEGORY_LIST = "category_list";
  static const PREF_BASKET = "basket";
  static const PREF_USER = "user";
  static const PREF_CATEGORY = "PREF_CATEGORY";
  static const PREF_LANG = "lang";
  static const PREF_FILTER = "PREF_FILTER";
  static const PREF_LOCATION = "location";
  static const FIRST_RUN = "FIRST_RUN";

  static SharedPreferences? _singleton;

  static SharedPreferences? getInstance() {
    return _singleton;
  }

  static initInstance() async {
    _singleton = await SharedPreferences.getInstance();
  }

  /*----------------------SERVER UCHUN------------------------------*/
  static BdmItemsModel? getBdmItems() {
    var json = _singleton?.getString(PREF_BDM_ITEMS);
    return json == null ? null : BdmItemsModel.fromJson(jsonDecode(json));
  }

  static Future<bool> setBdmItems(BdmItemsModel items) async {
    return _singleton!.setString(PREF_BDM_ITEMS, jsonEncode(items.toJson()));
  }

  static String getBaseUrl() {
    return _singleton?.getString(PREF_BASE_URL) ?? "";
  }

  static Future<bool> setBaseUrl(String value) async {
    return _singleton!.setString(PREF_BASE_URL, value);
  }

  static String getBaseImageUrl() {
    return _singleton?.getString(PREF_BASE_IMAGE_URL) ?? "";
  }

  static Future<bool> setBaseImageUrl(String value) async {
    return _singleton!.setString(PREF_BASE_IMAGE_URL, value);
  }

  //-------------------TOKEN----------------------------//
  static String getFCMToken() {
    return _singleton?.getString(PREF_FCM_TOKEN) ?? "";
  }

  static Future<bool> setFCMToken(String value) async {
    return _singleton!.setString(PREF_FCM_TOKEN, value);
  }

  static String getToken() {
    return _singleton?.getString(PREF_TOKEN) ?? "";
  }

  static Future<bool> setToken(String value) async {
    return _singleton!.setString(PREF_TOKEN, value);
  }

  static String getPublicOffer() {
    return _singleton?.getString(PREF_OFFERTA) ?? "";
  }

  static Future<bool> setPublicOffer(String value) async {
    return _singleton!.setString(PREF_OFFERTA, value);
  }

//------------------------FAVOURITE--------------------------//
  //FAVORITE
  static List<ProductModel> getFavoriteList() {
    var json = _singleton?.getString(PREF_FAVORITES);
    if (json == null) {
      return [];
    }
    return (jsonDecode(json) as List<dynamic>).map((js) => ProductModel.fromJson(js)).toList();
  }

  static Future<bool> addToFavorite(ProductModel item, bool isFavorite) async {
    var items = getFavoriteList();

    if (isFavorite) {
      items.removeWhere((element) => element.id == item.id);
    } else {
      items.add(item);
    }
    return await _singleton!.setString(PREF_FAVORITES, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  //-----------------A D D R E S S L A R   S A Q L A S H ------------------------//

  static List<MapItemModel> getAddressList() {
    var json = _singleton?.getString(PREF_ADDRESS);
    if (json == null) {
      return [];
    }
    var items = (jsonDecode(json) as List<dynamic>).map((js) => MapItemModel.fromJson(js));
    return items.toList();
  }

  static Future<bool> setNewAddress(MapItemModel? item) async {
    var items = getAddressList();
    if(item!=null) items.add(item);

    var r = await _singleton!.setString(PREF_ADDRESS, jsonEncode(items.map((item) => item.toJson()).toList()));
    return r;
  }

  static Future<bool> deleteAddress(MapItemModel item) async {
    var items = getAddressList();

    for (var element in items) {
      if (element.id == item.id && element.lat == item.lat && element.long == item.long) {
        items.remove(element);
        break;
      }
    }

    var r = await _singleton!.setString(PREF_ADDRESS, jsonEncode(items.map((e) => e.toJson()).toList()));
    return r;
  }

  static Future<bool> setActiveAdres(MapItemModel? item) async {
    var items = getAddressList();
    for (var element in items) {
      if (element.id == item?.id) {
        element.isChecked = true;
      } else {
        element.isChecked = false;
      }
    }

    return await _singleton!.setString(PREF_ADDRESS, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

//--------------------- C A R T    S A V D O ---------------------------------------//
  //CART LIST
  static List<ProductModel> getCartList() {
    var json = _singleton?.getString(PREF_BASKET);
    if (json == null) {
      return [];
    }
    return (jsonDecode(json) as List<dynamic>).map((js) => ProductModel.fromJson(js)).toList();
  }

  static double getCartCount(String id) {
    final items = PrefUtils.getCartList().where((element) => element.id == id).toList();
    return items.isNotEmpty ? items.first.cartCount : 0.0;
  }

  static Future<bool> addToCart(ProductModel item) async {
    print("PrefCartCOUNT - ${item.cartCount}");

    var items = getCartList();

    if (item.cartCount == 0) {
      var index = 0;
      var removeIndex = -1;

      for (var element in items) {
        if (element.id == item.id) {
          removeIndex = index;
        }
        index++;
      }
      if (removeIndex > -1) {
        items.removeAt(removeIndex);
      }
    } else {
      var isHave = false;
      for (var element in items) {
        if (element.id == item.id) {
          element.cartCount = item.cartCount;
          isHave = true;
        }
      }

      if (!isHave) {
        items.add(item);
      }
    }

    return await _singleton!.setString(PREF_BASKET, jsonEncode(items.map((e) => e.toJson()).toList()));
  }

  static Future<bool> clearCart() {
    return _singleton!.remove(PREF_BASKET);
  }

  //---------------------- U S E R    D E T A I L S ------------------------------//
  static Future<bool> setAdminPhones(List<PhoneNumberModel> items) async {
    var r = await _singleton!.setString(ADMIN_PHONES, jsonEncode(items.map((item) => item.toJson()).toList()));
    return r;
  }

  static List<PhoneNumberModel> getAdminPhones() {
    var json = _singleton!.getString(ADMIN_PHONES);
    if (json == null) {
      return [];
    }
    var items = (jsonDecode(json) as List<dynamic>).map((e) => PhoneNumberModel.fromJson(e)).toList();
    return items;
  }

  static UserInfoModel? getUser() {
    var json = _singleton?.getString(PREF_USER);

    return json == null ? null : UserInfoModel.fromJson(jsonDecode(json));
  }

  static Future<bool> setUser(UserInfoModel value) async {
    return _singleton!.setString(PREF_USER, jsonEncode(value.toJson()));
  }

  //---------------------------------------------------------------//

  // static CategoryModel? getSelecCategory() {
  //   var json = _singleton?.getString(PREF_CATEGORY);
  //
  //   return json == null ? null : CategoryModel.fromJson(jsonDecode(json));
  // }
  //
  // static Future<bool> setSelecCategory(CategoryModel? value) async {
  //   return _singleton!.setString(PREF_CATEGORY, jsonEncode(value?.toJson()));
  // }

  static List<FilterBrandModel> getFilterBrands() {
    var json = _singleton!.getString(PREF_FILTER);
    if (json == null) {
      return [];
    }
    var items = (jsonDecode(json) as List<dynamic>).map((e) => FilterBrandModel.fromJson(e)).toList();
    return items;
  }

  static Future<bool> setFilterBrands(List<FilterBrandModel> items) async{
    var r = await _singleton!.setString(PREF_FILTER, jsonEncode(items.map((item) => item.toJson()).toList()));
    return r;
  }

  static bool openBrandsFromHome() {
    return _singleton?.getBool("aaaaaaaaaa") ?? false;
  }

  static Future<bool> setOpenBrandsFromHome(bool value) async {
    return _singleton!.setBool("aaaaaaaaaa", value);
  }


  //----------------------------------------------------------------------------------//
  static String getLang() {
    return _singleton?.getString(PREF_LANG) ?? DEFAULT_LANG_KEY;
  }

  static Future<bool> setLang(String value) async {
    return _singleton!.setString(PREF_LANG, value);
  }

  static Future<bool> setFirstRun(bool value) async{
   return _singleton!.setBool(FIRST_RUN, value);
  }

  static bool isFirstRun(){
    return _singleton?.getBool(FIRST_RUN)?? true;
  }

  //----------------------------------------------------------------------------//

  static void clearAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
}
