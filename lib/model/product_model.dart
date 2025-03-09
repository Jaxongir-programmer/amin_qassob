import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class ProductModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  double limit;
  @HiveField(3)
  double price;
  @HiveField(4)
  final int category_id;
  @HiveField(5)
  final String unit;
  @HiveField(6)
  final String? image;
  @HiveField(7)
  final int brend_id;
  @HiveField(8)
  final String description;
  @HiveField(9)
  final String? status;
  @HiveField(10)
  final double? discount;
  @HiveField(11)
  final bool? top;
  @HiveField(12)
  final List<String?> photos;


  var cartCount = 0.0;
  var cartPrice = 0.0;
  var cartCashback = 0.0;

  ProductModel(
      this.id,
      this.title,
      this.limit,
      this.price,
      this.category_id,
      this.brend_id,
      this.image,
      this.status, this.unit, this.description, this.discount, this.top, this.photos,
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
