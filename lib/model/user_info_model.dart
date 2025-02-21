import 'package:json_annotation/json_annotation.dart';
import '../model/user_info_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String phone;
  final String name;
  final String id;
  final int? message_count;
  final String? store_id;
  final double orderRadius; //zakaz qabul qilish masofasi
  final double dostavkaSumma; //limitga yetmagan buyurtma uchun dastavka summasi
  final double orderSummaLimit; // Bepul yetqazish uchun summa limiti

  UserInfoModel(this.phone, this.name, this.id, this.message_count, this.store_id, this.orderRadius, this.dostavkaSumma, this.orderSummaLimit);

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
