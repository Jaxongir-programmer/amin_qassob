
import '../model/product_id_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_by_id_model.g.dart';

@JsonSerializable()
class ProductByIdModel{
  List<ProductIdModel> items;

  ProductByIdModel(this.items);

  factory ProductByIdModel.fromJson(Map<String, dynamic> json) => _$ProductByIdModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductByIdModelToJson(this);

}
