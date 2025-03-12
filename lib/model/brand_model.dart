import 'package:amin_qassob/model/size_model.dart';
import 'package:amin_qassob/model/tip_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@JsonSerializable()
class BrandModel {
  final int id;
  final String title;
  final int category;

  BrandModel(this.id, this.title, this.category);

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
