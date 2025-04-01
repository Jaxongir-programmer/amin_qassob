import 'dart:async';


import 'package:stacked/stacked.dart';

import '../../api/api_service.dart';
import '../../model/response/login_response.dart';
import '../../utils/pref_utils.dart';

class AuthViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  var progressData = false;

  StreamController<bool> _smsCheckPhoneStream = StreamController();

  Stream<bool> get smsCheckData {
    return _smsCheckPhoneStream.stream;
  }

  StreamController<LoginResponse> _loginResponseStream = StreamController();

  Stream<LoginResponse> get loginResponseData {
    return _loginResponseStream.stream;
  }

  StreamController<String> registerStream = StreamController();

  Stream<String> get registerData {
    return registerStream.stream;
  }

  StreamController<String> tokenStream = StreamController();

  Stream<String> get tokenData {
    return tokenStream.stream;
  }

  void smsCheck(String phone) async {
    progressData = true;
    notifyListeners();
    final data = await api.checkPhone(phone, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      _smsCheckPhoneStream.sink.add(data);
    }
  }

  void registration(String phone, String name, String surname, String code, String address) async {
    progressData = true;
    notifyListeners();
    final data = await api.registration(phone,code, name, surname, address,  _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      registerStream.sink.add(data);
    }
  }
  void login(String phone, String code) async {
    progressData = true;
    notifyListeners();
    final data = await api.login(phone,code, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      tokenStream.sink.add(data);
    }
  }

  void getPublicOffer() async {
    progressData = true;
    notifyListeners();
    final data = await api.getPublicOffer(_errorStream);
    if (data != null) {
      await PrefUtils.setPublicOffer(data);
    }
    progressData = false;
    notifyListeners();
  }

}
