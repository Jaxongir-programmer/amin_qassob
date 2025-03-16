import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../../api/api_service.dart';
import '../../../../model/make_order_model.dart';


class MakeOrderViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  final StreamController<dynamic> _makeOrderData = StreamController();

  Stream<dynamic> get makeOrderData {
    return _makeOrderData.stream;
  }

  final StreamController<dynamic> _paymentData = StreamController();

  Stream<dynamic> get paymentData {
    return _paymentData.stream;
  }

  var progressData = false;
  var progressOrderData = false;




  void makeOrder(MakeOrderModel orderModel) async {
    progressOrderData = true;
    notifyListeners();
    final data = await api.makeOrder(orderModel, _errorStream);
    if (data!=null) {
      _makeOrderData.sink.add(data);
    }
    progressOrderData = false;
    notifyListeners();
  }
  void payment(String image,int orderId) async {
    progressOrderData = true;
    notifyListeners();
    final data = await api.payment(image,orderId, _errorStream);
    if (data!=null) {
      _paymentData.sink.add(data);
    }
    progressOrderData = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }
}
