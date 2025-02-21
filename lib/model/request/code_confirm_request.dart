
import 'package:json_annotation/json_annotation.dart';

part 'code_confirm_request.g.dart';

@JsonSerializable()
class CodeConfirmRequest{
  final String phone;
  final String code;
  final String name;
  final String surName;
  final String address;

  CodeConfirmRequest(this.phone, this.code, this.name, this.surName, this.address);

  factory CodeConfirmRequest.fromJson(Map<String, dynamic> json) =>
      _$CodeConfirmRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CodeConfirmRequestToJson(this);
}