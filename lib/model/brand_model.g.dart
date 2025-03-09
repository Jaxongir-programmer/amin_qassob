// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandModelAdapter extends TypeAdapter<BrandModel> {
  @override
  final int typeId = 2;

  @override
  BrandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      (fields[4] as List).cast<TipModel>(),
      (fields[5] as List).cast<SizeModel>(),
      fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, BrandModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brendName)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.category_id)
      ..writeByte(4)
      ..write(obj.tip)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.childCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandModel _$BrandModelFromJson(Map<String, dynamic> json) => BrandModel(
      (json['id'] as num).toInt(),
      json['brendName'] as String,
      json['image'] as String,
      json['category_id'] as String,
      (json['tip'] as List<dynamic>)
          .map((e) => TipModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['size'] as List<dynamic>)
          .map((e) => SizeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['childCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BrandModelToJson(BrandModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brendName': instance.brendName,
      'image': instance.image,
      'category_id': instance.category_id,
      'tip': instance.tip,
      'size': instance.size,
      'childCount': instance.childCount,
    };
