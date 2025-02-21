// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductModel _$OrderProductModelFromJson(Map<String, dynamic> json) =>
    OrderProductModel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      (json['quantity'] as num).toDouble(),
      (json['price'] as num).toDouble(),
      (json['Keshback_foiz'] as num).toDouble(),
      (json['Keshback_summa'] as num).toDouble(),
    );

Map<String, dynamic> _$OrderProductModelToJson(OrderProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'price': instance.price,
      'Keshback_foiz': instance.Keshback_foiz,
      'Keshback_summa': instance.Keshback_summa,
    };
