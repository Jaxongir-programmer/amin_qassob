import 'package:json_annotation/json_annotation.dart';

part 'basket_model.g.dart';

@JsonSerializable()
class BasketModel {
  final String id;
  double count;
  double price;
  double keshbek;

  BasketModel(this.id, this.count,this.price,this.keshbek);

  factory BasketModel.fromJson(Map<String, dynamic> json) =>
      _$BasketModelFromJson(json);

  Map<String, dynamic> toJson() => _$BasketModelToJson(this);
}
