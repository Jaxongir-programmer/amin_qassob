import 'package:json_annotation/json_annotation.dart';

part 'cashback_model.g.dart';

@JsonSerializable()
class CashBackModel{
  final double Prixod;
  final double Ostatka;
  final double Rasxod;

  CashBackModel(this.Prixod, this.Ostatka, this.Rasxod);

  factory CashBackModel.fromJson(Map<String, dynamic> json) => _$CashBackModelFromJson(json);

  Map<String, dynamic> toJson() => _$CashBackModelToJson(this);
}