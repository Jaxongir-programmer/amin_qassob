// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_brand_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterBrandModel _$FilterBrandModelFromJson(Map<String, dynamic> json) =>
    FilterBrandModel(
      json['checked'] as bool,
      json['show'] as bool,
      json['id'] as String,
      json['text'] as String,
      (json['children'] as List<dynamic>)
          .map((e) => FilterBrandModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FilterBrandModelToJson(FilterBrandModel instance) =>
    <String, dynamic>{
      'checked': instance.checked,
      'show': instance.show,
      'id': instance.id,
      'text': instance.text,
      'children': instance.children,
    };
