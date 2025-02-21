
import 'dart:async';

import '../../../api/api_service.dart';
import 'package:event_bus/event_bus.dart';
import 'package:stacked/stacked.dart';

import '../../../model/event_model.dart';
import '../../../model/message_model.dart';
import '../../../utils/constants.dart';
import '../../../utils/pref_utils.dart';
import '../../../service/eventbus.dart';

class MessageViewModel extends BaseViewModel {
  final api = ApiService();

  StreamController<String> _errorStream = StreamController();

  StreamController<int> _errorCodeStream = StreamController();

  Stream<int> get errorCodeData {
    return _errorCodeStream.stream;
  }

  Stream<String> get errorData {
    return _errorStream.stream;
  }

  var progressData = false;

  List<MessageModel> messageList = [];

  void getMessageList() async {
    progressData = true;
    notifyListeners();
    messageList = await api.getMessage(_errorStream);
    if (messageList.isNotEmpty) {
      getUser();
    }
    progressData = false;
    notifyListeners();
  }

  void getUser() async {
    notifyListeners();
    final data = await api.getUser(_errorStream,_errorCodeStream);
    if (data != null) {
      PrefUtils.setUser(data);
      eventBus.fire(EventModel(event: EVENT_UPDATE_MESSAGE_BADGE, data: data.message_count));
    }
    notifyListeners();
  }


  @override
  void dispose() {
    _errorStream.close();
    super.dispose();
  }
}
