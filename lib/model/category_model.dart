
import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final int id;
  final String title;
  final String? cat_image;
  final int? childCount;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);

  CategoryModel(this.id, this.title, this.cat_image, this.childCount);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
