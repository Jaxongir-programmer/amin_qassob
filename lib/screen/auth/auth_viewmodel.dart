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

  StreamController<String> _successStream = StreamController();

  Stream<String> get successData {
    return _successStream.stream;
  }

  var progressData = false;

  StreamController<bool> _smsCheckPhoneStream = StreamController();

  Stream<bool> get smsCheckData {
    return _smsCheckPhoneStream.stream;
  }

  StreamController<String> _telegramLoginStream = StreamController();

  Stream<String> get telegramLoginData {
    return _telegramLoginStream.stream;
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
    final data = await api.checkPhone(phone, _successStream, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      telegramLogin(phone);
      _smsCheckPhoneStream.sink.add(data);
    }
  }

  void telegramLogin(String phone) async {
    progressData = true;
    notifyListeners();
    final data = await api.telegramLogin(phone, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      _telegramLoginStream.sink.add(data);
    }
  }

  void registration(String id, String phone, String name, String surname, String code, String address) async {
    progressData = true;
    notifyListeners();
    final data = await api.registration(id, phone, code, name, surname, address, _errorStream);
    progressData = false;
    notifyListeners();
    if (data != null) {
      registerStream.sink.add(data);
    }
  }

  void login(String phone, String code) async {
    progressData = true;
    notifyListeners();
    final data = await api.login(phone, code, _errorStream);
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

  @override
  void dispose() {
    _errorStream.close();
    _loginResponseStream.close();
    _smsCheckPhoneStream.close();
    _telegramLoginStream.close();
    super.dispose();
  }
}
