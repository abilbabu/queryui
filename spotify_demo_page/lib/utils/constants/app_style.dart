import 'package:flutter/material.dart';

class AppStyle {
   static TextStyle getTitleStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.bold,
      color: color,
    );
  }

  static TextStyle getTextStyle(
      {required double fontSize, Color? color, bool isCurrency = false}) {
    return TextStyle(
      fontSize: fontSize,
      fontFamily: isCurrency ? null : "Poppins",
      fontWeight: FontWeight.w600,
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