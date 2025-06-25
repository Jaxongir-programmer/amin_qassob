// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderModel _$MakeOrderModelFromJson(Map<String, dynamic> json) =>
    MakeOrderModel(
      json['user_id'] as String,
      json['full_name'] as String,
      json['comment'] as String,
      json['order_time'] as String,
      json['phone2'] as String,
      json['lat'] as String,
      json['lon'] as String,
      (json['deliver_summa'] as num).toDouble(),
      (json['payment_type'] as num).toInt(),
      json['address'] as String,
      (json['products'] as List<dynamic>)
          .map((e) => MakeOrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MakeOrderModelToJson(MakeOrderModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'full_name': instance.full_name,
      'comment': instance.comment,
      'order_time': instance.order_time,
      'phone2': instance.phone2,
      'lat': instance.lat,
      'lon': instance.lon,
      'deliver_summa': instance.deliver_summa,
      'payment_type': instance.payment_type,
      'address': instance.address,
      'products': instance.products,
    };
