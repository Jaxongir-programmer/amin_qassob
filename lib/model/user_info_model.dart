import 'package:json_annotation/json_annotation.dart';
import '../model/user_info_model.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final String id;
  final String last_name;
  final String first_name;
  final String phone_number;
  final int? message_count;
  final double? orderRadius; //zakaz qabul qilish masofasi
  final double deliver_summa; //limitga yetmagan buyurtma uchun dastavka summasi
  final double? orderSummaLimit; // Bepul yetqazish uchun summa limiti

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

  UserInfoModel(this.id, this.last_name, this.first_name, this.phone_number, this.message_count, this.orderRadius, this.deliver_summa, this.orderSummaLimit);

  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
