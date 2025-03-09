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
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as double,
      fields[4] as int,
      fields[7] as int,
      fields[6] as String?,
      fields[9] as String?,
      fields[5] as String,
      fields[8] as String,
      fields[10] as double?,
      fields[11] as bool?,
      (fields[12] as List).cast<String?>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.limit)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.category_id)
      ..writeByte(5)
      ..write(obj.unit)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.brend_id)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.status)
      ..writeByte(10)
      ..write(obj.discount)
      ..writeByte(11)
      ..write(obj.top)
      ..writeByte(12)
      ..write(obj.photos);
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
      (json['id'] as num).toInt(),
      json['title'] as String,
      (json['limit'] as num).toDouble(),
      (json['price'] as num).toDouble(),
      (json['category_id'] as num).toInt(),
      (json['brend_id'] as num).toInt(),
      json['image'] as String?,
      json['status'] as String?,
      json['unit'] as String,
      json['description'] as String,
      (json['discount'] as num?)?.toDouble(),
      json['top'] as bool?,
      (json['photos'] as List<dynamic>).map((e) => e as String?).toList(),
      (json['cartCount'] as num?)?.toDouble() ?? 0,
      (json['cartPrice'] as num?)?.toDouble() ?? 0,
      (json['cartCashback'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'limit': instance.limit,
      'price': instance.price,
      'category_id': instance.category_id,
      'unit': instance.unit,
      'image': instance.image,
      'brend_id': instance.brend_id,
      'description': instance.description,
      'status': instance.status,
      'discount': instance.discount,
      'top': instance.top,
      'photos': instance.photos,
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
