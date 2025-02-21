// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'make_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MakeOrderModel _$MakeOrderModelFromJson(Map<String, dynamic> json) =>
    MakeOrderModel(
      json['user_id'] as String,
      json['store_id'] as String,
      json['comment'] as String,
      json['orderTime'] as String,
      json['phone2'] as String,
      json['lat'] as String,
      json['lon'] as String,
      (json['total_cashback'] as num).toDouble(),
      (json['deliver_summa'] as num).toDouble(),
      (json['total_amount'] as num).toDouble(),
      (json['paymentType'] as num).toInt(),
      (json['deliver_gender'] as num).toInt(),
      json['orientr'] as String,
      json['address'] as String,
      (json['products'] as List<dynamic>)
          .map((e) => MakeOrderProduct.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MakeOrderModelToJson(MakeOrderModel instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'store_id': instance.store_id,
      'comment': instance.comment,
      'orderTime': instance.orderTime,
      'phone2': instance.phone2,
      'lat': instance.lat,
      'lon': instance.lon,
      'total_cashback': instance.total_cashback,
      'deliver_summa': instance.deliver_summa,
      'total_amount': instance.total_amount,
      'paymentType': instance.paymentType,
      'deliver_gender': instance.deliver_gender,
      'orientr': instance.orientr,
      'address': instance.address,
      'products': instance.products,
    };
