// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductIdModel _$ProductIdModelFromJson(Map<String, dynamic> json) =>
    ProductIdModel(
      (json['id'] as num).toInt(),
    )
      ..image = json['image'] as String?
      ..name = json['name'] as String?;

Map<String, dynamic> _$ProductIdModelToJson(ProductIdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
    };
