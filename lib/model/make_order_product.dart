
import 'package:json_annotation/json_annotation.dart';

part 'make_order_product.g.dart';

@JsonSerializable()
class MakeOrderProduct {
  final String id;
  final double quantity;
  final double quantity_pack;
  final double price;
  final double cashback;
  final double cashback_foiz;
  final bool cashback_blok;

  MakeOrderProduct(this.id, this.quantity, this.quantity_pack, this.price, this.cashback, this.cashback_foiz, this.cashback_blok);

  factory MakeOrderProduct.fromJson(Map<String, dynamic> json) => _$MakeOrderProductFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOrderProductToJson(this);
}
