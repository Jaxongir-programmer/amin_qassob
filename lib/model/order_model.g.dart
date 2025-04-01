// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      (json['id'] as num).toInt(),
      json['created'] as String,
      json['comment'] as String,
      (json['total_price'] as num).toDouble(),
      (json['products'] as List<dynamic>)
          .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecode(_$OrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created': instance.created,
      'comment': instance.comment,
      'total_price': instance.total_price,
      'products': instance.products,
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.WAITING: 'waiting',
  OrderStatus.ACCEPTED: 'accepted',
  OrderStatus.COMPLETED: 'completed',
  OrderStatus.CANCELED: 'canceled',
};
