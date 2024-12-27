import 'package:flutter/material.dart';

class Appstyle {
  static TextStyle getTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w700,
      color: color,
    );
  }

  static TextStyle getSubTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontStyle: FontStyle.italic,
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w400,
      color: color,
    );
  }
}
