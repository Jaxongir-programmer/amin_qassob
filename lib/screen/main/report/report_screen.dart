import 'package:amin_qassob/screen/main/report/report_viewmodel.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

class ReportScreen extends StatefulWidget {
  String reportType;

  ReportScreen({required this.reportType,Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportViewModel>.reactive(
      viewModelBuilder: () => ReportViewModel(),
      builder:
          (BuildContext context, ReportViewModel viewModel, Widget? child) {
        return Scaffold(
          appBar: AppBar(title: widget.reportType == "report_list"? const Text("Akt Hisoboti") : const Text("Kashbek hisoboti"), backgroundColor: ACCENT_COLOR),
          body: Column(
            children: [
              IntrinsicHeight(
                child: InkWell(
                  onTap: () {
                    _selectDate(context, viewModel);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Boshlang'ish vaqt",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd.MM.yyyy")
                                        .format(selectedStartDate),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        IntrinsicHeight(
                          child: Container(
                            width: 1,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Text(
                                    "Tugash vaqti",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    DateFormat("dd.MM.yyyy")
                                        .format(selectedEndDate),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade200,
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "№",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        )),
                    IntrinsicHeight(
                      child: Container(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Sarlavhalar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        )),
                    IntrinsicHeight(
                      child: Container(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "+",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        )),
                    IntrinsicHeight(
                      child: Container(
                        width: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    const Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "-",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade200,
              ),
              viewModel.progressData
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: SingleChildScrollView(
                      child: Column(
                        children: viewModel.report == null
                            ? []
                            : [
                                IntrinsicHeight(
                                  child: Container(
                                    color: Colors.blue,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(8.0),
                                              child: Text(
                                                "*",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel.report!.saldo.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel
                                                    .report!.saldo.plus_summa
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel
                                                    .report!.saldo.minus_summa
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                    itemCount: viewModel.report!.table.length,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemBuilder: (_, position) {
                                      var item = viewModel.report!.table[position];
                                      return IntrinsicHeight(
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item.id.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )),
                                            IntrinsicHeight(
                                              child: Container(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 4,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item.title,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )),
                                            IntrinsicHeight(
                                              child: Container(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item.plus_summa.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )),
                                            IntrinsicHeight(
                                              child: Container(
                                                width: 1,
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    item.minus_summa.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                      );
                                    }),
                          IntrinsicHeight(
                            child: Container(
                              color: Colors.green,
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                children: [
                                  const Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding:
                                        EdgeInsets.all(8.0),
                                        child: Text(
                                          "*",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  IntrinsicHeight(
                                    child: Container(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          viewModel
                                              .report!.oborot.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  IntrinsicHeight(
                                    child: Container(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          viewModel
                                              .report!.oborot.plus_summa.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                  IntrinsicHeight(
                                    child: Container(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          viewModel
                                              .report!.oborot.minus_summa.toString(),
                                          textAlign: TextAlign.center,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                                IntrinsicHeight(
                                  child: Container(
                                    color: Colors.orange,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        const Expanded(
                                            flex: 1,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.all(8.0),
                                              child: Text(
                                                "*",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel
                                                    .report!.dolg.title
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel
                                                    .report!.dolg.plus_summa
                                                    .toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                        IntrinsicHeight(
                                          child: Container(
                                            width: 1,
                                            color: Colors.grey.shade300,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                viewModel
                                                    .report!.oborot.minus_summa
                                                    .toString(),
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                      ),
                    ))
            ],
          ),
        );
      },
      onModelReady: (viewModel) {

        if (widget.reportType == REPORT_LIST) {
          viewModel.getReport(DateFormat("ddMMyyyy").format(selectedStartDate),
              DateFormat("ddMMyyyy").format(selectedEndDate));
        }else{
          if (widget.reportType == REPORT_CASHBACK) {
            viewModel.getReportCashback(DateFormat("ddMMyyyy").format(selectedStartDate),
                DateFormat("ddMMyyyy").format(selectedEndDate));
          }
        }

      },
    );
  }

  Future<void> _selectDate(
      BuildContext context, ReportViewModel viewModel) async {
    final date = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (date != null) {
      setState(() {
        selectedStartDate = date.start;
        selectedEndDate = date.end;
        viewModel.getReport(DateFormat("ddMMyyyy").format(selectedStartDate),
            DateFormat("ddMMyyyy").format(selectedEndDate));
      });
    }
  }
}
