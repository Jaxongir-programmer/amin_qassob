// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      json['phone'] as String,
      json['name'] as String,
      json['id'] as String,
      (json['message_count'] as num?)?.toInt(),
      json['store_id'] as String?,
      (json['orderRadius'] as num).toDouble(),
      (json['dostavkaSumma'] as num).toDouble(),
      (json['orderSummaLimit'] as num).toDouble(),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'id': instance.id,
      'message_count': instance.message_count,
      'store_id': instance.store_id,
      'orderRadius': instance.orderRadius,
      'dostavkaSumma': instance.dostavkaSumma,
      'orderSummaLimit': instance.orderSummaLimit,
    };
