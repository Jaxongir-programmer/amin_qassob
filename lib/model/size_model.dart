import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'size_model.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class SizeModel {
  @HiveField(0)
  final String size_id;
  @HiveField(1)
  final String size_Name;
  bool checked;

  SizeModel(this.size_id, this.size_Name, [this.checked = false]);

  factory SizeModel.fromJson(Map<String, dynamic> json) =>
      _$SizeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SizeModelToJson(this);
}
