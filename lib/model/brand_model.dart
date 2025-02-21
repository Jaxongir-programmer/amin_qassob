import 'package:amin_qassob/model/size_model.dart';
import 'package:amin_qassob/model/tip_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class BrandModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String brendName;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String category_id;
  @HiveField(4)
  final List<TipModel> tip;
  @HiveField(5)
  final List<SizeModel> size;
  @HiveField(6)
  final int? childCount;

  BrandModel(this.id, this.brendName, this.image, this.category_id, this.tip,
      this.size, this.childCount);

  factory BrandModel.fromJson(Map<String, dynamic> json) =>
      _$BrandModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandModelToJson(this);
}
