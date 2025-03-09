// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderProduct _$MakeOrderProductFromJson(Map<String, dynamic> json) =>
    MakeOrderProduct(
      (json['product_id'] as num).toInt(),
      (json['count'] as num).toDouble(),
      (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$MakeOrderProductToJson(MakeOrderProduct instance) =>
    <String, dynamic>{
      'product_id': instance.product_id,
      'count': instance.count,
      'price': instance.price,
    };
