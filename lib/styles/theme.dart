import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/styles/colors.dart';

class CustomTheme {
  static ThemeData get primaryTheme {
    return ThemeData(
      scaffoldBackgroundColor: ColorsApp.white,
      fontFamily: "Montserrat",
      appBarTheme: AppBarTheme(
        color: ColorsApp.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: ColorsApp.blue),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
   
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: ColorsApp.black),
        //   borderRadius: BorderRadius.circular(28.0),
        //   gapPadding: 10.0,
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: ColorsApp.black),
        //   borderRadius: BorderRadius.circular(28.0),
        //   gapPadding: 10.0,
        // ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: ColorsApp.black),
        //   borderRadius: BorderRadius.circular(28.0),
        //   gapPadding: 10.0,
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: ColorsApp.black),
        //   borderRadius: BorderRadius.circular(28.0),
        //   gapPadding: 10.0,
        // ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsApp.green),
          borderRadius: BorderRadius.circular(28.0),
          gapPadding: 7.0,
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
