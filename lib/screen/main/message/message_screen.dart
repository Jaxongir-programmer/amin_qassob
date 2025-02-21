// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_colors.dart';
import '../../../view/message_view.dart';
import 'message_viewmodel.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MessageViewModel>.reactive(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text("Bildirishnomalar"),
              ),
              body: Container(
                child: viewModel.progressData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: viewModel.messageList.length,
                        itemBuilder: (_, position) {
                          var item = viewModel.messageList[viewModel.messageList.length - position - 1];
                          return MessageView(color: RANDOM_COLORS[position % RANDOM_COLORS.length], item);
                        }),
              ),
            ),
          ],
        );
      },
      viewModelBuilder: () {
        return MessageViewModel();
      },
      onViewModelReady: (viewModel) {
        viewModel.errorData.listen((event) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(SnackBar(content: Text(event)));
        });
        viewModel.getMessageList();
      },
    );
  }
}
