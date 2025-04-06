
import '../model/order_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel{
  final int id;
  final String created;
  final String comment;
  final double total_price;
  final List<OrderProductModel> products;
  final OrderStatus status;
  final bool paid;

  OrderModel(this.id, this.created, this.comment, this.total_price, this.products, this.status, this.paid);

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

enum OrderStatus{
  @JsonValue("waiting") WAITING,
  @JsonValue("accepted") ACCEPTED,
  @JsonValue("completed") COMPLETED,
  @JsonValue("canceled") CANCELED,
}