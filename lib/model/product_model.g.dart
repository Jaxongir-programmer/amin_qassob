// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as int,
      fields[3] as double,
      fields[4] as double,
      fields[5] as double,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
      fields[9] as double,
      fields[10] as bool,
      fields[11] as double,
      fields[12] as String,
      fields[13] as String,
      fields[14] as String,
      fields[15] as String,
      (fields[16] as List).cast<Images>(),
      fields[17] as String?,
      fields[18] as String?,
      fields[19] as double?,
      fields[20] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.limit)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.minimum_price)
      ..writeByte(6)
      ..write(obj.category_id)
      ..writeByte(7)
      ..write(obj.unity)
      ..writeByte(8)
      ..write(obj.image)
      ..writeByte(9)
      ..write(obj.kash_back_foiz)
      ..writeByte(10)
      ..write(obj.kash_back_blok)
      ..writeByte(11)
      ..write(obj.sht)
      ..writeByte(12)
      ..write(obj.brend_id)
      ..writeByte(13)
      ..write(obj.tavsif)
      ..writeByte(14)
      ..write(obj.tip_id)
      ..writeByte(15)
      ..write(obj.size_id)
      ..writeByte(16)
      ..write(obj.images)
      ..writeByte(17)
      ..write(obj.status)
      ..writeByte(18)
      ..write(obj.country)
      ..writeByte(19)
      ..write(obj.skidka)
      ..writeByte(20)
      ..write(obj.status_color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ImagesAdapter extends TypeAdapter<Images> {
  @override
  final int typeId = 5;

  @override
  Images read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Images(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Images obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      json['id'] as String,
      json['name'] as String,
      (json['code'] as num).toInt(),
      (json['limit'] as num).toDouble(),
      (json['price'] as num).toDouble(),
      (json['minimum_price'] as num).toDouble(),
      json['category_id'] as String,
      json['unity'] as String,
      json['image'] as String,
      (json['kash_back_foiz'] as num).toDouble(),
      json['kash_back_blok'] as bool,
      (json['sht'] as num).toDouble(),
      json['brend_id'] as String,
      json['tavsif'] as String,
      json['tip_id'] as String,
      json['size_id'] as String,
      (json['images'] as List<dynamic>)
          .map((e) => Images.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['status'] as String?,
      json['country'] as String?,
      (json['skidka'] as num?)?.toDouble(),
      json['status_color'] as String?,
      (json['cartCount'] as num?)?.toDouble() ?? 0,
      (json['cartPrice'] as num?)?.toDouble() ?? 0,
      (json['cartCashback'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'limit': instance.limit,
      'price': instance.price,
      'minimum_price': instance.minimum_price,
      'category_id': instance.category_id,
      'unity': instance.unity,
      'image': instance.image,
      'kash_back_foiz': instance.kash_back_foiz,
      'kash_back_blok': instance.kash_back_blok,
      'sht': instance.sht,
      'brend_id': instance.brend_id,
      'tavsif': instance.tavsif,
      'tip_id': instance.tip_id,
      'size_id': instance.size_id,
      'images': instance.images,
      'status': instance.status,
      'country': instance.country,
      'skidka': instance.skidka,
      'status_color': instance.status_color,
      'cartCount': instance.cartCount,
      'cartPrice': instance.cartPrice,
      'cartCashback': instance.cartCashback,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      json['image'] as String,
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'image': instance.image,
    };
