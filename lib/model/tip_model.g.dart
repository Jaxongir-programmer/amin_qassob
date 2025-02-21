// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tip_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TipModelAdapter extends TypeAdapter<TipModel> {
  @override
  final int typeId = 3;

  @override
  TipModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TipModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TipModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.tip_id)
      ..writeByte(1)
      ..write(obj.tip_Name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TipModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipModel _$TipModelFromJson(Map<String, dynamic> json) => TipModel(
      json['tip_id'] as String,
      json['tip_Name'] as String,
      json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$TipModelToJson(TipModel instance) => <String, dynamic>{
      'tip_id': instance.tip_id,
      'tip_Name': instance.tip_Name,
      'checked': instance.checked,
    };
