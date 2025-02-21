// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAddressModel _$MyAddressModelFromJson(Map<String, dynamic> json) =>
    MyAddressModel(
      (json['lat'] as num?)?.toDouble(),
      (json['long'] as num?)?.toDouble(),
      json['addressName'] as String,
      json['addressComment'] as String,
    )..isChecked = json['isChecked'] as bool;

Map<String, dynamic> _$MyAddressModelToJson(MyAddressModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'long': instance.long,
      'addressName': instance.addressName,
      'addressComment': instance.addressComment,
      'isChecked': instance.isChecked,
    };
