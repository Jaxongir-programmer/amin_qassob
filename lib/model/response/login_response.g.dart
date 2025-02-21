// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['id'] as String,
      json['name'] as String,
      json['phone'] as String,
      json['adress'] as String,
      json['lat'] as String,
      json['long'] as String,
      json['image'] as String,
      (json['keshback'] as num).toDouble(),
      json['policies'] as String,
      json['about'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'adress': instance.adress,
      'lat': instance.lat,
      'long': instance.long,
      'image': instance.image,
      'keshback': instance.keshback,
      'policies': instance.policies,
      'about': instance.about,
    };
