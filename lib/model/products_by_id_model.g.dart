// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_by_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductByIdModel _$ProductByIdModelFromJson(Map<String, dynamic> json) =>
    ProductByIdModel(
      (json['items'] as List<dynamic>)
          .map((e) => ProductIdModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductByIdModelToJson(ProductByIdModel instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
