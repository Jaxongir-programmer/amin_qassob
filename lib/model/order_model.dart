
import '../model/order_product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel{
  final String id;
  final String date;
  final String comment;
  final double totalAmount;
  final double Kashback_Itog;
  final List<OrderProductModel> products;
  final OrderStatus status;

  OrderModel(this.id, this.date, this.comment, this.totalAmount, this.Kashback_Itog, this.products, this.status);

  factory OrderModel.fromJson(Map<String, dynamic> json) => _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

enum OrderStatus{
  @JsonValue("waiting") WAITING,
  @JsonValue("accepted") ACCEPTED,
  @JsonValue("completed") COMPLETED,
  @JsonValue("canceled") CANCELED,
}