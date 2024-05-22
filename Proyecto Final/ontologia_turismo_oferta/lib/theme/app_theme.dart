import 'package:flutter/material.dart';

class AppTheme {
  //colores globales
  static const Color customBackgroundColor = Color(0xffedf2fa);
  static const Color customAppBarColor = Color(0xff09184d);
  static const Color customTitleColor = Color(0xff2f2e2e);
  static const Color customiInfoColor = Color(0xff808085);
  static const Color customButtomsColor = Color(0xff7b5bf2);
  static const Color customCardColor = Color(0xffF1EDFF);
  static const Color customCardColor2 = Color(0xffFFFBFF);
  static Decoration customizedDecoration1 = BoxDecoration(
      color: customCardColor2,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: customAppBarColor.withOpacity(0.4),
          offset: const Offset(1, 2),
          blurRadius: 4,
        ),
      ]);
  static Decoration customizedDecoration2 = BoxDecoration(
      color: customCardColor2,
      borderRadius: BorderRadius.circular(5),
      boxShadow: [
        BoxShadow(
          color: customAppBarColor.withOpacity(0.4),
          offset: const Offset(1, 2),
          blurRadius: 4,
        ),
      ]);

  static LinearGradient linearGradient = LinearGradient(colors: [
    customAppBarColor.withOpacity(0.6),
    Colors.transparent,
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static LinearGradient linearGradient2 = LinearGradient(colors: [
    customAppBarColor.withOpacity(0.4),
    Colors.transparent,
    Colors.transparent
  ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
