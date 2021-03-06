import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/styles/colors.dart';

//light 300
//regular- standar 400
//medium 500
//semibold 600
//bold 700
//black 90

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: ColorsApp.white,
    fontFamily: "Transat",
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorsApp.green,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ColorsApp.white),
    ),
    accentColor: ColorsApp.orange,
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
      color: ColorsApp.blueObscured,
    ),
    headline2: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
      color: ColorsApp.blueObscured,
    ),
    subtitle1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: ColorsApp.blueObscured,
    ),
    subtitle2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: ColorsApp.white,
    ),
    bodyText1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w900,
      color: ColorsApp.blueObscured,
    ),
    bodyText2: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: ColorsApp.blueObscured,
    ),
    caption: TextStyle(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: ColorsApp.white,
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: ColorsApp.blueObscured),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
