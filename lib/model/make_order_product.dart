
import 'package:json_annotation/json_annotation.dart';

part 'make_order_product.g.dart';

@JsonSerializable()
class MakeOrderProduct {
  final int product_id;
  final double count;
  final double price;

  MakeOrderProduct(this.product_id, this.count, this.price);

  factory MakeOrderProduct.fromJson(Map<String, dynamic> json) => _$MakeOrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOrderProductToJson(this);
}
