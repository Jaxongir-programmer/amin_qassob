import 'dart:async';

import 'package:stacked/stacked.dart';

import '../../../api/api_service.dart';
import '../../../model/response/report_response.dart';

class ReportViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();
  Stream<String> get errorData {
    return _errorStream.stream;
  }

  ReportResponse? report;

  var progressData = false;

  void getReport(String startDate, String endDate) async {
    progressData = true;
    notifyListeners();
    report = await api.getReport(startDate, endDate, _errorStream);
    progressData = false;
    notifyListeners();
    notifyListeners();
  }

  void getReportCashback(String startDate, String endDate) async {
    progressData = true;
    notifyListeners();
    report = await api.getReportCashback(startDate, endDate, _errorStream);
    progressData = false;
    notifyListeners();
    notifyListeners();
  }

  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }
}
