import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tip_model.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class TipModel {
  @HiveField(0)
  final String tip_id;
  @HiveField(1)
  final String tip_Name;
  bool checked;

  TipModel(this.tip_id, this.tip_Name, [this.checked = false]);

  factory TipModel.fromJson(Map<String, dynamic> json) =>
      _$TipModelFromJson(json);

  Map<String, dynamic> toJson() => _$TipModelToJson(this);
}
