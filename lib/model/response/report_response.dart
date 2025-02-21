import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

import '../report_item_model.dart';


part 'report_response.g.dart';

@JsonSerializable()
class ReportResponse {
  final ReportItemModel saldo;
  final List<ReportItemModel> table;
  final ReportItemModel oborot;
  final ReportItemModel dolg;

  ReportResponse(this.saldo, this.table, this.oborot, this.dolg);

  factory ReportResponse.fromJson(Map<String, dynamic> json) =>
      _$ReportResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReportResponseToJson(this);
}
