import 'package:json_annotation/json_annotation.dart';

part 'order_product_model.g.dart';

@JsonSerializable()
class OrderProductModel{
  final int id;
  final String? name;
  final double count;
  final double price;

  OrderProductModel(this.id, this.name, this.count, this.price);

  factory OrderProductModel.fromJson(Map<String, dynamic> json) => _$OrderProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderProductModelToJson(this);
}