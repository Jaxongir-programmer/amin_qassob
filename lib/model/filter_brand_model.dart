import 'package:json_annotation/json_annotation.dart';

part 'filter_brand_model.g.dart';

@JsonSerializable()
class FilterBrandModel {
   bool checked;
   bool show;
   String id;
   String text;
   List<FilterBrandModel> children;

  FilterBrandModel(this.checked, this.show, this.id, this.text, this.children);

  factory FilterBrandModel.fromJson(Map<String, dynamic> json) => _$FilterBrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterBrandModelToJson(this);
}
