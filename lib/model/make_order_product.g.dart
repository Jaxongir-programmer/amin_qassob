// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderProduct _$MakeOrderProductFromJson(Map<String, dynamic> json) =>
    MakeOrderProduct(
      json['id'] as String,
      (json['quantity'] as num).toDouble(),
      (json['quantity_pack'] as num).toDouble(),
      (json['price'] as num).toDouble(),
      (json['cashback'] as num).toDouble(),
      (json['cashback_foiz'] as num).toDouble(),
      json['cashback_blok'] as bool,
    );

Map<String, dynamic> _$MakeOrderProductToJson(MakeOrderProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'quantity_pack': instance.quantity_pack,
      'price': instance.price,
      'cashback': instance.cashback,
      'cashback_foiz': instance.cashback_foiz,
      'cashback_blok': instance.cashback_blok,
    };
