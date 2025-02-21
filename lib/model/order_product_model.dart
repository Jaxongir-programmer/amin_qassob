import 'package:json_annotation/json_annotation.dart';

part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel{
  final int id;
  final String name;
  final double quantity;
  final double price;
  final double Keshback_foiz;
  final double Keshback_summa;

  OrderProductModel(this.id, this.name, this.quantity, this.price, this.Keshback_foiz, this.Keshback_summa);

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}