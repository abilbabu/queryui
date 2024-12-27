import 'package:flutter/material.dart';

class ColorConstants {
  static const Color PrimaryColor = Color(0xFF1206FF);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightGrey = Color(0xFFBBBBBB);
  static const Color darkgery = Color(0xFF262626);
  static const Color transparent = Color(0x00000000);
  static const Color blue = Color(0xFF0073FF);

  static const List<Color> Containerbordercolor = [
    Color(0xFFFF0000),
    Color(0xFF00FF00),
    Color(0xFF289EFF),
    Color(0xFFFFFF00),
    Color(0xFF800080)
  ];

  static const List<BoxShadow> boxShadow = [
    BoxShadow(
      color: Color(0x3F000000),
      blurRadius: 10,
      // spreadRadius: 5,
      offset: Offset(5, 5),
    ),
  ];
}
