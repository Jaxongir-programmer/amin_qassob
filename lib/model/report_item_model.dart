
import 'package:json_annotation/json_annotation.dart';

part 'report_item_model.g.dart';

@JsonSerializable()
class ReportItemModel {
  final int id;
  final String title;
  final double plus_summa;
  final double minus_summa;

  ReportItemModel(this.id, this.title, this.plus_summa, this.minus_summa);

  factory ReportItemModel.fromJson(Map<String, dynamic> json) => _$ReportItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportItemModelToJson(this);
}
