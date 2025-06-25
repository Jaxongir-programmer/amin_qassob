// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) =>
    UserInfoModel(
      json['id'] as String,
      json['phone_number'] as String?,
      (json['message_count'] as num?)?.toInt(),
      (json['orderRadius'] as num?)?.toDouble(),
      (json['deliver_summa'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone_number': instance.phone_number,
      'message_count': instance.message_count,
      'orderRadius': instance.orderRadius,
      'deliver_summa': instance.deliver_summa,
    };
