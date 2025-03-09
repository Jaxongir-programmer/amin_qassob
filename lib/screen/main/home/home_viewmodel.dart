import 'dart:async';
import 'package:amin_qassob/model/brand_model.dart';
import 'package:amin_qassob/model/filter_brand_model.dart';
import 'package:amin_qassob/model/phone_number_model.dart';
import 'package:hive/hive.dart';

import '../../../model/cashback_model.dart';
import '../../../model/category_model.dart';
import 'package:stacked/stacked.dart';

import '../../../api/api_service.dart';
import '../../../model/event_model.dart';
import '../../../model/offer_model.dart';
import '../../../model/order_model.dart';
import '../../../model/product_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../service/eventbus.dart';

class HomeViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  StreamController<int> _errorCodeStream = StreamController();

  Stream<int> get errorCodeData {
    return _errorCodeStream.stream;
  }

  StreamController<List<ProductModel>> _allProductStream = StreamController();

  Stream<List<ProductModel>> get allProductData {
    return _allProductStream.stream;
  }

  StreamController<List<FilterBrandModel>> _allFilterBrandStream = StreamController();

  Stream<List<FilterBrandModel>> get allFilterBranData {
    return _allFilterBrandStream.stream;
  }

  StreamController<List<PhoneNumberModel>> _phoneListStream = StreamController();

  Stream<List<PhoneNumberModel>> get adminPhonesData {
    return _phoneListStream.stream;
  }

  StreamController<List<BrandModel>> _allBrandsStream = StreamController();

  Stream<List<BrandModel>> get allBrandsData {
    return _allBrandsStream.stream;
  }

  StreamController<List<BrandModel>> _allGroupsStream = StreamController();

  Stream<List<BrandModel>> get allGroupsData {
    return _allGroupsStream.stream;
  }

  StreamController<List<ProductModel>> _productsByIdStream = StreamController();

  Stream<List<ProductModel>> get productsByIdData {
    return _productsByIdStream.stream;
  }

  bool progressData = false;
  bool topTovarProgress = false;
  bool skidkaTovarProgress = false;
  bool categoriesProgress = false;
  bool orderProgress = false;
  bool progressCartData = false;
  List<String> offerList = [];

  List<CategoryModel> categoryList = [];
  OfferModel? offer;

  List<ProductModel> productList = [];
  List<ProductModel> productByCategoryList = [];
  List<ProductModel> productByBrandList = [];
  List<FilterBrandModel> filterBrandList = [];
  List<PhoneNumberModel> phoneList = [];
  List<OrderModel> orderList = [];
  List<ProductModel> topTovarList = [];
  List<ProductModel> skidkaTovarList = [];
  ProductModel? topProduct;

  List<OfferModel> photosList = [];

  late final Box<ProductModel> box = Hive.box<ProductModel>('products_table');

  void getUser() async {
    progressData = true;
    notifyListeners();
    final data = await api.getUser(_errorStream, _errorCodeStream);
    progressData = false;
    notifyListeners();

    if (data != null) {
      PrefUtils.setUser(data);
      getProductList();
      getCategoryList();
      eventBus.fire(EventModel(event: EVENT_UPDATE_MESSAGE_BADGE, data: data.message_count));
    }
  }

  void getOffer() async {
    progressData = true;
    notifyListeners();
    final data = await api.getOffer(_errorStream);
    if (data != null) {
      photosList = data;
    }
    progressData = false;
    notifyListeners();
  }

  void getTopTovar() async {
    topTovarProgress = true;
    notifyListeners();
    topTovarList = await api.getTopTovar(_errorStream);
    topTovarProgress = false;
    notifyListeners();
  }

  void getSkidkaTovar() async {
    skidkaTovarProgress = true;
    notifyListeners();
    skidkaTovarList = await api.getSkidkaTovar(_errorStream);
    skidkaTovarProgress = false;
    notifyListeners();
  }

  void getCategoryList() async {
    categoriesProgress = true;
    notifyListeners();
    categoryList = await api.getCategoryList(_errorStream);
    categoriesProgress = false;
    notifyListeners();
  }

  void getBrandList() async {
    notifyListeners();
    final data = await api.getBrandList(_errorStream);
    notifyListeners();
    if (data.isNotEmpty) {
      _allBrandsStream.sink.add(data);
    }
  }

  void getGroupList() async {
    notifyListeners();
    final data = await api.getGroupList(_errorStream);
    notifyListeners();
    if (data.isNotEmpty) {
      _allGroupsStream.sink.add(data);
    }
  }

  void getProductList() async {
    progressData = true;
    notifyListeners();
    productList = await api.getProductList(_errorStream);
    progressData = false;
    notifyListeners();

    if (productList.isNotEmpty) {
      _allProductStream.sink.add(productList);
    }
  }

  void getProductByCategory(int catId) async {
    progressData = true;
    notifyListeners();
    productByCategoryList = await api.getProductByCategory(catId, _errorStream);
    progressData = false;
    notifyListeners();
  }

  void getProductByBrand(int catId, int brandId) async {
    progressData = true;
    notifyListeners();
    productByBrandList = await api.getProductByBrand(catId, brandId, _errorStream);
    progressData = false;
    notifyListeners();
  }

  // void getFilterBrands() async {
  //   progressData = true;
  //   notifyListeners();
  //   filterBrandList = await api.getFilterBrands(_errorStream);
  //   if (filterBrandList.isNotEmpty) {
  //     _allFilterBrandStream.sink.add(filterBrandList);
  //   }
  //   progressData = false;
  //   notifyListeners();
  // }

  void getAdminPhones() async {
    progressData = true;
    notifyListeners();
    phoneList = await api.getAdminPhones(_errorStream);
    progressData = false;
    if (phoneList.isNotEmpty) {
      PrefUtils.setAdminPhones(phoneList);
    }
    notifyListeners();
  }

  void getOrderList() async {
    orderProgress = true;
    notifyListeners();
    orderList = await api.getOrderList(_errorStream);
    orderProgress = false;
    notifyListeners();
  }

  void getProductsByIds(productsById) async {
    progressCartData = true;
    notifyListeners();
    final data = await api.getProductsByIds(productsById, _errorStream);
    progressCartData = false;
    notifyListeners();

    if (data.isNotEmpty) {
      _productsByIdStream.sink.add(data);
    }
  }

  @override
  void dispose() {
    _errorStream.close();
    _allProductStream.close();
    _productsByIdStream.close();
    super.dispose();
  }
}
