// https://stackoverflow.com/questions/38908285/how-do-i-add-methods-or-values-to-enums-in-dart

import 'package:json_annotation/json_annotation.dart';

enum AuthState { phone, smsCode, registration}

enum EnumLanguages {
  en("en"),
  ru("ru"),
  uz("uz"),
  ko("ko");

  const EnumLanguages(this.value);

  final String value;

  String toJson() => name;
  static EnumLanguages fromJson(String json) => values.byName(json);
}
