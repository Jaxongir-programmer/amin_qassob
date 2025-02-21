import 'dart:core';

import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String id;
  final String name;
  final String phone;
  final String adress;
  final String lat;
  final String long;
  final String image;
  final double keshback;
  final String policies;
  final String about;

  LoginResponse(this.id, this.name, this.phone, this.adress, this.lat,
      this.long, this.image, this.keshback, this.policies, this.about);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
