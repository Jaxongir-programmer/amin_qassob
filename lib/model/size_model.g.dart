// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeModelAdapter extends TypeAdapter<SizeModel> {
  @override
  final int typeId = 4;

  @override
  SizeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SizeModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SizeModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.size_id)
      ..writeByte(1)
      ..write(obj.size_Name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeModel _$SizeModelFromJson(Map<String, dynamic> json) => SizeModel(
      json['size_id'] as String,
      json['size_Name'] as String,
      json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$SizeModelToJson(SizeModel instance) => <String, dynamic>{
      'size_id': instance.size_id,
      'size_Name': instance.size_Name,
      'checked': instance.checked,
    };
