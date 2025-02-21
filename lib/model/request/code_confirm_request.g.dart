// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_confirm_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodeConfirmRequest _$CodeConfirmRequestFromJson(Map<String, dynamic> json) =>
    CodeConfirmRequest(
      json['phone'] as String,
      json['code'] as String,
      json['name'] as String,
      json['surName'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$CodeConfirmRequestToJson(CodeConfirmRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'code': instance.code,
      'name': instance.name,
      'surName': instance.surName,
      'address': instance.address,
    };
