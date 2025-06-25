// import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:amin_qassob/generated/assets.dart';

import '../model/offer_model.dart';
import '../model/order_model.dart';
import 'package:flutter/cupertino.dart';

Color lightgreenshede = Color(0xFFF0FAF6);
Color lightgreenshede1 = Color(0xFFB2D9CC);
Color greenshede0 = Color(0xFF66A690);
Color greenshede1 = Color(0xFF93C9B5);
Color primarygreen = Color(0xFF1E3A34);
Color grayshade = Color(0xFF93B3AA);
Color colorAcent = Color(0xFF78C2A7);
Color cyanColor = Color(0xFF6D7E6E);

const kAnimationDuration = Duration(milliseconds: 200);

const SECRET_NAME = "TestGSMMobiles";
const APP_TYPE = "client";
const BASE_URL = "https://api.aminqassob.uz/api/";
const BASE_IMAGE_URL = "https://api.aminqassob.uz";

const uzEnLangKey = "en";
const ruLangKey = "ru";
const uzLangKey = "uz";
const koLangKey = "ko";
const defaultLangKey = uzLangKey;

// const defaultLocationYandex = Point(latitude: 40.538809199846185, longitude: 70.93768802572866);
const String noSelected = "Tanlanmagan";
const LANG_SELECTED = "lang_selected";

const EVENT_UPDATE_CART = 1;
const EVENT_UPDATE_BADGE = 2;
const EVENT_UPDATE_MESSAGE_BADGE = 3;
const EVENT_UPDATE_STATE = 4;
const EVENT_SELECT_CATEGORY = 5;
const EVENT_SELECT_BRAND = 6;

const REPORT_LIST = "report_list";
const REPORT_CASHBACK = "report_cashback";

class Constants {
  static List<OrderModel> orderList = [];

  static List<OfferModel> photosList = [
    OfferModel(1, "", "", Assets.imagesAppLogo),
    OfferModel(2, "", "", Assets.imagesAppLogo),
    OfferModel(3, "", "", Assets.imagesAppLogo),
    OfferModel(4, "", "", Assets.imagesAppLogo),
    OfferModel(5, "", "", Assets.imagesAppLogo),
  ];
}
