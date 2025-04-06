

import 'dart:ui';

// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/enum.dart';

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

extension CustomDateTime on DateTime {
  get formattedDate {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  get formattedDateTime {
    return DateFormat('dd.MM.yyyy HH:mm:ss').format(this);
  }
}

extension CustomTime on TimeOfDay {
  get formattedTime {
    return "${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}";
  }
}

extension CustomString on String {
  get formattedDateTime {
    var date = DateTime.tryParse(this);
    return date != null
        ? DateFormat('dd.MM.yyyy HH:mm:ss').format(date)
        : formattedDateTime;
  }
}

extension CustomDouble on double {
  String formattedAmountString() {
    return NumberFormat.currency(locale: "uz", symbol: "")
        .format(this)
        .replaceAll(",00", "");
  }
}

extension CustomDoubleFixed on double {
  String formattedAmountStringFixed() {
    return NumberFormat.currency(locale: "uz", symbol: "")
        .format(this)
        .replaceAll(",00", "").replaceAll(RegExp(r"\s+\b|\b\s"), "");
  }
}

extension CustomStringToDouble on String {
  double parseToDouble() {
    var value = replaceAll(RegExp(r"\s+\b|\b\s"), "");
    var item = double.parse(value.isEmpty ? "0" : value);

    return item;
  }
}

extension CustomLanguage on EnumLanguages {
  String get language {
    switch (this) {
      case EnumLanguages.en:
        return "English";
      case EnumLanguages.uz:
        return "O‘zbekcha";
      case EnumLanguages.ru:
        return "Русский";
      case EnumLanguages.ko:
        return "한국어";
    }
  }
}
