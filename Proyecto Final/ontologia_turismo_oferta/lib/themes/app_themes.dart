import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.deepPurpleAccent;
  static const Color secundary = Colors.red;
  static const Color terciario = Colors.orange;

  static ThemeData lightTeme = ThemeData.light();
  static ThemeData darctTeme = ThemeData.dark();

  static const Color globalColor = primary;
  static final ThemeData _globalTheme = lightTeme;

  static final ThemeData globalTheme = _globalTheme.copyWith(
    primaryColor: globalColor,
    //
    appBarTheme: const AppBarTheme(
      color: globalColor,
      elevation: 0,
    ),
  );
}
