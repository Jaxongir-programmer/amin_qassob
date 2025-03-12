// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      (json['id'] as num).toInt(),
      json['title'] as String,
      json['cat_image'] as String?,
      (json['childCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cat_image': instance.cat_image,
      'childCount': instance.childCount,
    };
