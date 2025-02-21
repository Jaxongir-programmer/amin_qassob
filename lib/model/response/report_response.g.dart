// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportResponse _$ReportResponseFromJson(Map<String, dynamic> json) =>
    ReportResponse(
      ReportItemModel.fromJson(json['saldo'] as Map<String, dynamic>),
      (json['table'] as List<dynamic>)
          .map((e) => ReportItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      ReportItemModel.fromJson(json['oborot'] as Map<String, dynamic>),
      ReportItemModel.fromJson(json['dolg'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReportResponseToJson(ReportResponse instance) =>
    <String, dynamic>{
      'saldo': instance.saldo,
      'table': instance.table,
      'oborot': instance.oborot,
      'dolg': instance.dolg,
    };
