
import '../model/make_order_product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_order_model.g.dart';

@JsonSerializable()
class MakeOrderModel{
  String user_id;
  String store_id;
  String comment;
  String orderTime;
  String phone2;
  String lat;
  String lon;
  double total_cashback;
  double deliver_summa;
  double total_amount;
  int paymentType;
  int deliver_gender;
  String orientr;
  String address;
  List<MakeOrderProduct> products;

  MakeOrderModel(this.user_id,this.store_id, this.comment, this.orderTime, this.phone2, this.lat, this.lon, this
      .total_cashback, this.deliver_summa, this.total_amount, this.paymentType, this.deliver_gender, this.orientr, this.address, this.products);

  factory MakeOrderModel.fromJson(Map<String, dynamic> json) => _$MakeOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOrderModelToJson(this);

}