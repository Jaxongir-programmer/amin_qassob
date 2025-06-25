import '../model/make_order_product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'make_order_model.g.dart';

@JsonSerializable()
class MakeOrderModel {
  String user_id;
  String full_name;
  String comment;
  String order_time;
  String phone2;
  String lat;
  String lon;
  double deliver_summa;
  int payment_type;
  String address;
  List<MakeOrderProduct> products;

  MakeOrderModel(this.user_id,this.full_name, this.comment, this.order_time, this.phone2, this.lat, this.lon, this.deliver_summa,
      this.payment_type, this.address, this.products);

  factory MakeOrderModel.fromJson(Map<String, dynamic> json) => _$MakeOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$MakeOrderModelToJson(this);
}
