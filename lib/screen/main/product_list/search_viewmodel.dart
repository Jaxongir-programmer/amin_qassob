import 'dart:async';

import 'package:amin_qassob/model/brand_model.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

import '../../../api/api_service.dart';
import '../../../model/cashback_model.dart';
import '../../../model/category_model.dart';
import '../../../model/offer_model.dart';
import '../../../model/product_model.dart';

class SearchViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  StreamController<List<ProductModel>> _allProductStream = StreamController();

  Stream<List<ProductModel>> get allProductData {
    return _allProductStream.stream;
  }

  late final Box<ProductModel> box = Hive.box<ProductModel>('products_table');
  late final Box<BrandModel> boxBrands = Hive.box<BrandModel>('brands_table');
  var progressData = false;
  List<String> offerList = [];

  List<CategoryModel> categoryList = [];
  OfferModel? offer;

  CashBackModel? cashback;
  List<ProductModel> productList = [];

  void getProductList(
    String keyword,
  ) async {
    notifyListeners();
    List<String> keywords = keyword.split(" ");

    print(keywords);

    if (keyword.isEmpty) {
      productList.clear();
      productList = box.values.toList();
    }

    if (keywords.length == 1) {
      productList =
          box.values.where((element) => (element.title.toLowerCase().contains(keyword.toLowerCase()))).toList();
    } else if (keywords.length == 2) {
      productList = box.values
          .where((element) =>
              (element.title.toLowerCase().contains(keywords.first.toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[1].toLowerCase())))
          .toList();
    } else {
      productList = box.values
          .where((element) =>
              (element.title.toLowerCase().contains(keywords.first.toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[1].toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[2].toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  void getProductsByBrand(String keyword, int brandId) async {
    notifyListeners();

    List<String> keywords = keyword.split(" ");

    print(keywords);

    if (keyword.isEmpty) {
      productList.clear();
      productList = box.values.where((element) => (element.brend_id == brandId)).toList();
    }

    if (keywords.length == 1) {
      productList = box.values
          .where((element) =>
              ((element.brend_id == brandId) && element.title.toLowerCase().contains(keyword.toLowerCase())))
          .toList();
    } else if (keywords.length == 2) {
      productList = box.values
          .where((element) =>
              (element.brend_id == brandId) &&
              (element.title.toLowerCase().contains(keywords.first.toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[1].toLowerCase())))
          .toList();
    } else {
      productList = box.values
          .where((element) =>
              (element.brend_id == brandId) &&
              (element.title.toLowerCase().contains(keywords.first.toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[1].toLowerCase())) &&
              (element.title.toLowerCase().contains(keywords[2].toLowerCase())))
          .toList();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }
}
