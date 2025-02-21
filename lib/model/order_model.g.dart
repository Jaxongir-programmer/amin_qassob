// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['id'] as String,
      json['date'] as String,
      json['comment'] as String,
      (json['totalAmount'] as num).toDouble(),
      (json['Kashback_Itog'] as num).toDouble(),
      (json['products'] as List<dynamic>)
          .map((e) => OrderProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecode(_$OrderStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'comment': instance.comment,
      'totalAmount': instance.totalAmount,
      'Kashback_Itog': instance.Kashback_Itog,
      'products': instance.products,
      'status': _$OrderStatusEnumMap[instance.status]!,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.WAITING: 'waiting',
  OrderStatus.ACCEPTED: 'accepted',
  OrderStatus.COMPLETED: 'completed',
  OrderStatus.CANCELED: 'canceled',
};
