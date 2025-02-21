

import 'package:json_annotation/json_annotation.dart';

part 'my_address_model.g.dart';

@JsonSerializable()
class MyAddressModel{
  double? lat;
  double? long;
  String addressName;
  String addressComment;
  bool isChecked = false;

  MyAddressModel(this.lat, this.long, this.addressName, this.addressComment);

  factory MyAddressModel.fromJson(Map<String, dynamic> json) => _$MyAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyAddressModelToJson(this);
}