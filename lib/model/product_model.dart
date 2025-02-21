import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int code;
  @HiveField(3)
  double limit;
  @HiveField(4)
  double price;
  @HiveField(5)
  final double minimum_price;
  @HiveField(6)
  final String category_id;
  @HiveField(7)
  final String unity;
  @HiveField(8)
  final String image;
  @HiveField(9)
  final double kash_back_foiz;
  @HiveField(10)
  final bool kash_back_blok;
  @HiveField(11)
  final double sht;
  @HiveField(12)
  final String brend_id;
  @HiveField(13)
  final String tavsif;
  @HiveField(14)
  final String tip_id;
  @HiveField(15)
  final String size_id;
  @HiveField(16)
  final List<Images> images;
  @HiveField(17)
  final String? status;
  @HiveField(18)
  final String? country;
  @HiveField(19)
  final double? skidka;
  @HiveField(20)
  final String? status_color;

  var cartCount = 0.0;
  var cartPrice = 0.0;
  var cartCashback = 0.0;

  ProductModel(
      this.id,
      this.name,
      this.code,
      this.limit,
      this.price,
      this.minimum_price,
      this.category_id,
      this.unity,
      this.image,
      this.kash_back_foiz,
      this.kash_back_blok,
      this.sht,
      this.brend_id,
      this.tavsif,
      this.tip_id,
      this.size_id,
      this.images,
      this.status,
      this.country,
      this.skidka,
      this.status_color,
      [this.cartCount = 0,
      this.cartPrice = 0,
      this.cartCashback = 0]);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@HiveType(typeId: 5)
@JsonSerializable()
class Images {
  @HiveField(0)
  final String image;

  Images(this.image);

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}
