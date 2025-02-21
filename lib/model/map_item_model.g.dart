// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapItemModel _$MapItemModelFromJson(Map<String, dynamic> json) => MapItemModel(
      (json['id'] as num).toDouble(),
      json['name'] as String,
      json['reName'] as String,
      (json['lat'] as num).toDouble(),
      (json['long'] as num).toDouble(),
      json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$MapItemModelToJson(MapItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reName': instance.reName,
      'lat': instance.lat,
      'long': instance.long,
      'isChecked': instance.isChecked,
    };
