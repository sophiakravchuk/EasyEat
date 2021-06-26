import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignConfiguration {
  static final Size size = Size(414, 896);
}

class EasyEatColors {
  static final Color white = Color.fromRGBO(248, 253, 248, 1);
  static final Color lightGreen = Color.fromRGBO(196, 218, 180, 1);
  static final Color dirtyGreen = Color.fromRGBO(116, 142, 99, 1);
  static final Color darkGreen = Color.fromRGBO(16, 52, 9, 1);
  static final Color green = Color.fromRGBO(40, 167, 69, 1);
  static final Color black = Color.fromRGBO(21, 22, 18, 1);
  static final Color orange = Color.fromRGBO(237, 121, 49, 1);
  static final Color grey = Color.fromRGBO(225, 225, 225, 1);
  static final Color darkGrey = Color.fromRGBO(163, 163, 163, 1);
}

class EasyEatTextStyle {

  Color textColor;
  FontWeight fontWeight;
  double fontSize;
  TextDecoration decoration;

  EasyEatTextStyle({Color textColor, String fontFamily, FontWeight fontWeight, double fontSize, TextDecoration decoration}) {
    this.textColor = textColor ?? EasyEatColors.black;
    this.fontWeight = fontWeight ?? FontWeight.bold;
    this.fontSize = fontSize ?? 18;
    this.decoration = decoration ?? null;
  }

  TextStyle style() =>  GoogleFonts.rokkitt(
    color: textColor,
    fontWeight: fontWeight,
    fontSize: fontSize,
    decoration: decoration,
  );

}