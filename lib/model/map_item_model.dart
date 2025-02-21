import 'package:json_annotation/json_annotation.dart';

part 'map_item_model.g.dart';

@JsonSerializable()
class MapItemModel {
  final double id;
  final String name;
  String reName;
  final double lat;
  final double long;
  bool isChecked = false;

  MapItemModel(this.id, this.name, this.reName, this.lat, this.long, [this.isChecked = false]);

  factory MapItemModel.fromJson(Map<String, dynamic> json) => _$MapItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$MapItemModelToJson(this);
}
