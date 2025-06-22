import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amin_qassob/model/brand_model.dart';
import 'package:amin_qassob/model/phone_number_model.dart';
import 'package:amin_qassob/utils/constants.dart';

import '../model/category_model.dart';
import '../model/filter_brand_model.dart';
import '../model/make_order_model.dart';
import '../model/message_model.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';
import '../model/products_by_id_model.dart';
import '../model/response/report_response.dart';
import '../model/user_info_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../main.dart';
import '../model/base_model.dart';
import '../model/offer_model.dart';
import '../screen/main/main_screen.dart';
import '../utils/pref_utils.dart';

class ApiService {
  final dio = Dio();

  ApiService() {
    // dio.options.baseUrl = PrefUtils.getBaseUrl();
    dio.options.baseUrl = BASE_URL;
    dio.options.headers.addAll({
      'Content-Type': 'application/json',
      if (PrefUtils.getToken().isNotEmpty) 'Authorization': 'Bearer ${PrefUtils.getToken()}',
      // 'token': PrefUtils.getToken(),
      'device': Platform.operatingSystem,
      // 'lang': PrefUtils.getLanguage(),
      'Connection': "close",
    });

    if (PrefUtils.getToken().isNotEmpty) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.headers['Authorization'] = 'Bearer ${PrefUtils.getToken()}';
            return handler.next(options);
          },
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept-Language'] = PrefUtils.getLanguage().value;
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(MyApp.alice.getDioInterceptor());
  }

  BaseModel wrapResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = BaseModel.fromJson(response.data);
      if (!data.error) {
        return data;
      } else {
        if (data.error_code == 405) {}
      }
      return data;
    } else if (response.statusCode == 401) {
      handleUnauthorized();
      return BaseModel(false, "Unauthorized", 401, null);
    } else {
      return BaseModel(false, response.statusMessage ?? "Unknown error ${response.statusCode}", -1, null);
    }
  }

  Future<void> handleUnauthorized() async {
    PrefUtils.clearAll();
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/main',
          (route) => false,
    );
  }

  String wrapError(DioError error) {
    if (kDebugMode) {
      return error.message.toString();
    }
    switch (error.type) {
      case DioErrorType.connectionError:
        return "Network error.";
      case DioErrorType.cancel:
        return "Unknown error.";
      case DioErrorType.connectionTimeout:
        return "Unknown error.";
      case DioErrorType.receiveTimeout:
        return "Unknown error.";
      case DioErrorType.sendTimeout:
        return "Unknown error.";
      case DioErrorType.badResponse:
        return "Unknown error.";
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        break;
      case DioExceptionType.unknown:
        // TODO: Handle this case.
        break;
    }
    return error.message.toString();
  }

  Future<bool?> checkPhone(String phone,StreamController<String> successStream, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/check-phone/", data: jsonEncode({"phone_number": phone}));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        successStream.sink.add(baseData.message ?? "Code sent to your Telegram account");
        return baseData.data["is_register"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<bool?> sendEmail(String email,StreamController<String> successStream, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/send/code/", data: jsonEncode({"email": email}));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        successStream.sink.add(baseData.message ?? "Code sent to your Telegram account");
        return true;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<String?> checkEmail(String email,String code, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/check/email/",
          data: jsonEncode({
            "email": email,
            "code": code,
          }));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        // Map<String, dynamic> decodedToken = JwtDecoder.decode(baseData.data["access_token"]);
        // PrefUtils.setToken(decodedToken['user_id']);
        // return decodedToken['user_id'];
        PrefUtils.setToken(baseData.data["access_token"]);
        return baseData.data["access_token"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }


  Future<String?> telegramLogin(String phone, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/telegram-login/", data: jsonEncode({"phone_number": phone}));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return baseData.data["id"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }


  Future<String?> registration(String id,
      String phone, String code, String firstName, String lastName, String address, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/register/",
          data: jsonEncode({
            "id": id,
            "phone_number": phone,
            "code": code,
            "first_name": firstName,
            "last_name": lastName,
            "address": address,
          }));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        // Map<String, dynamic> decodedToken = JwtDecoder.decode(baseData.data["access_token"]);
        // PrefUtils.setToken(decodedToken['user_id']);
        // return decodedToken['user_id'];
        PrefUtils.setToken(baseData.data["access_token"]);
        return baseData.data["access_token"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<String?> login(String phone, String code, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v3/login/",
          data: jsonEncode({
            "phone_number": phone,
            "code": code,
          }));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        // Map<String, dynamic> decodedToken = JwtDecoder.decode(baseData.data["access_token"]);
        // PrefUtils.setToken(decodedToken['user_id']);
        // return decodedToken['user_id'];

        PrefUtils.setToken(baseData.data["access_token"]);
        return baseData.data["access_token"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<List<CategoryModel>> getCategoryList(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/categories");
      print(response);
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<BrandModel>> getBrandList(int catId, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/category/$catId/brends/");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => BrandModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<BrandModel>> getGroupList(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("clientGetBrendCategory");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => BrandModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  // Future<List<FilterBrandModel>> getFilterBrands(StreamController<String> errorStream) async {
  //   try {
  //     final response = await dio.get("clientGetforFilter");
  //     final baseData = wrapResponse(response);
  //     if (!baseData.error) {
  //       return (baseData.data as List<dynamic>).map((json) => FilterBrandModel.fromJson(json)).toList();
  //     } else {
  //       errorStream.sink.add(baseData.message ?? "Error");
  //     }
  //   } on DioError catch (e) {
  //     errorStream.sink.add(wrapError(e));
  //   }
  //   return [];
  // }

  Future<List<OfferModel>> getOffer(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v2/offers");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => OfferModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<OrderModel>> getOrderList(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v4/my-orders/", queryParameters: {"user_id": PrefUtils.getUser()?.id});
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => OrderModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getTopTovar(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/top");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        try {
          return (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        } catch (e) {
          errorStream.sink.add("Malumotlarni o'qishda xatolik yuz berdi!");
        }
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getSkidkaTovar(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/discount");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        try {
          return (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        } catch (e) {
          errorStream.sink.add("Malumotlarni o'qishda xatolik yuz berdi!");
        }
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getProductList(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/all-products");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        var items = (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        return items;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getProductByCategory(int catId, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/category/${catId}");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        var items = (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        return items;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getProductByBrand(int catId, int brandId, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v1/category/$catId//brend/$brandId/");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        var items = (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        return items;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<UserInfoModel?> getUser(StreamController<String> errorStream, StreamController<int> errorCodeStream) async {
    try {
      final response = await dio.get("v3/get_user/", queryParameters: {"fcm": PrefUtils.getFCMToken()});

      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return UserInfoModel.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
        errorCodeStream.sink.add(baseData.error_code ?? 0);
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<dynamic> makeOrder(MakeOrderModel orderModel, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v4/order_model/", data: jsonEncode(orderModel));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return baseData.data["id"];
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<dynamic> payment(String image, int orderId, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("v5/payment/",
          data: FormData.fromMap({
            "payment_image": await MultipartFile.fromFile(image, filename: image.split('/').last),
            "order": orderId,
          }));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return baseData.data;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<ReportResponse?> getReport(String startDate, String endDate, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("ClientSverkaList", queryParameters: {
        "bsana": startDate,
        "osana": endDate,
        "user_id": PrefUtils.getUser()?.id ?? "",
      });

      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return ReportResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<ReportResponse?> getReportCashback(String startDate, String endDate, StreamController<String> errorStream) async {
    try {
      final response = await dio.get("ClientSverkaKashBack", queryParameters: {
        "bsana": startDate,
        "osana": endDate,
        "user_id": PrefUtils.getUser()?.id ?? "",
      });

      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return ReportResponse.fromJson(baseData.data);
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<List<MessageModel>> getMessage(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("getMessage", queryParameters: {});
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => MessageModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<PhoneNumberModel>> getAdminPhones(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("GetforNomer");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => PhoneNumberModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<List<ProductModel>> getProductsByIds(ProductByIdModel productByIdModel, StreamController<String> errorStream) async {
    try {
      final response = await dio.post("clientgetProductsByIds", queryParameters: {}, data: jsonEncode(productByIdModel));
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        var items = (baseData.data as List<dynamic>).map((json) => ProductModel.fromJson(json)).toList();
        return items;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioError catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return [];
  }

  Future<String?> getPublicOffer(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v2/offerta/1");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return baseData.data["text"] as String;
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioException catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }

  Future<List<OrderModel>?> getOrders(StreamController<String> errorStream) async {
    try {
      final response = await dio.get("v4/my-orders/");
      final baseData = wrapResponse(response);
      if (!baseData.error) {
        return (baseData.data as List<dynamic>).map((json) => OrderModel.fromJson(json)).toList();
      } else {
        errorStream.sink.add(baseData.message ?? "Error");
      }
    } on DioException catch (e) {
      errorStream.sink.add(wrapError(e));
    }
    return null;
  }
}
