// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      (json['id'] as num).toInt(),
      json['product_title'] as String?,
      (json['count'] as num).toDouble(),
      (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_title': instance.product_title,
      'count': instance.count,
      'price': instance.price,
    };
