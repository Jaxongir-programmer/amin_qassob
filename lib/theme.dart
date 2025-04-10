import 'package:amin_qassob/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData appTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Urbanist',
      appBarTheme:  AppBarTheme(
        // color: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: COLOR_PRIMARY),
        titleTextStyle: const TextStyle(color: COLOR_PRIMARY, fontSize:20, fontWeight: FontWeight.w500 ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: PRIMARY_COLOR,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: PRIMARY_COLOR,
          systemNavigationBarIconBrightness: Brightness.light,

          statusBarBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: PRIMARY_COLOR,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      inputDecorationTheme: inputDecorationTheme(),
      // visualDensity: VisualDensity.adaptivePlatformDensity,
    );

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder enableBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(
        color: SILVER, width: 1.2
      ));

  OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide:  const BorderSide(
        color: PRIMARY_COLOR, width: 1,
      ));

  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 8),
    filled: false,
    // fillColor: Colors.grey.shade300,
    enabledBorder: enableBorder,
    disabledBorder: enableBorder,
    focusedBorder: focusedBorder,
    // border: outlineInputBorder,
  );
}
