import 'package:flutter/material.dart';

class ColorsApp {
  static var blue = Color.fromRGBO(22, 102, 225, 1.0);
  static var blueOp50 = Color.fromRGBO(22, 102, 225, 0.5);
  static var red = Color.fromRGBO(242, 98, 95, 1.0);
  static var green = Color.fromRGBO(87, 164, 43, 1.0);
  static var purple = Color.fromRGBO(78, 39, 99, 1.0);
  static var yellow = Color.fromRGBO(240, 201, 95, 1.0);
  static var blackOp25 = Color.fromRGBO(36, 58, 76, 0.25);
  static var blackOp35 = Color.fromRGBO(36, 58, 76, 0.35);
  static var blackOp50 = Color.fromRGBO(36, 58, 76, 0.5);
  static var blackOp100 = Color.fromRGBO(36, 58, 76, 1.0);
  static var white = Color.fromRGBO(250, 250, 250, 1.0);
  static var black = Color.fromRGBO(33, 60, 76, 1.0);
  static var grey = Color.fromRGBO(232, 234, 236, 1.0);
  static var greyOp75 = Color.fromRGBO(232, 234, 236, 0.75);
}

class AppFlatButton {
  static var styleShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0));
  static var stylePadding = EdgeInsets.symmetric(horizontal: 35, vertical: 10);
}

class AppFonts {
  static var title = "Monserrat";
  static var text = "OpenSans";
  static var size35 = 35.0;
  static var size24 = 24.0;
  static var size16 = 16.0;
  static var size12 = 12.0;
  static var weightLight = FontWeight.w100;
  static var weightNormal = FontWeight.w400;
  static var weightSemiBold = FontWeight.w600;
  static var weightBold = FontWeight.w700;
}