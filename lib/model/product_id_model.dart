import 'package:json_annotation/json_annotation.dart';

part 'product_id_model.g.dart';

@JsonSerializable()
class ProductIdModel{
  String id;
  String? image;
  String? name;

  ProductIdModel(this.id);
  factory ProductIdModel.fromJson(Map<String, dynamic> json) => _$ProductIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductIdModelToJson(this);
}