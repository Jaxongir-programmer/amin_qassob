// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportItemModel _$ReportItemModelFromJson(Map<String, dynamic> json) =>
    ReportItemModel(
      (json['id'] as num).toInt(),
      json['title'] as String,
      (json['plus_summa'] as num).toDouble(),
      (json['minus_summa'] as num).toDouble(),
    );

Map<String, dynamic> _$ReportItemModelToJson(ReportItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'plus_summa': instance.plus_summa,
      'minus_summa': instance.minus_summa,
    };
