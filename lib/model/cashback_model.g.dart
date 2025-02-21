// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashback_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CashBackModel _$CashBackModelFromJson(Map<String, dynamic> json) =>
    CashBackModel(
      (json['Prixod'] as num).toDouble(),
      (json['Ostatka'] as num).toDouble(),
      (json['Rasxod'] as num).toDouble(),
    );

Map<String, dynamic> _$CashBackModelToJson(CashBackModel instance) =>
    <String, dynamic>{
      'Prixod': instance.Prixod,
      'Ostatka': instance.Ostatka,
      'Rasxod': instance.Rasxod,
    };
