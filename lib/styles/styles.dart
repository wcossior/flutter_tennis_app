import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class AppColors {
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

class AppTextFields {
  static var border = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(3.0),
  );
}

class AppText {
  static var blackNormalOpenSans_16 = TextStyle(
    color: AppColors.black,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightNormal,
  );
  static var whiteNormalOpenSans_16 = TextStyle(
    color: AppColors.white,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightNormal,
  );
  static var redNormalOpenSans_12 = TextStyle(
    color: AppColors.red,
    fontSize: AppFonts.size12,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightNormal,
  );
  static var whiteLightOpenSans_16 = TextStyle(
    color: AppColors.white,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightLight,
  );

  static var blackLightOpenSans_16 = TextStyle(
    color: AppColors.black,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightLight,
  );
  static var blueSemiBoldOpenSans_16 = TextStyle(
    color: AppColors.blue,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightSemiBold,
  );
  static var whiteSemiBoldOpenSans_16 = TextStyle(
    color: AppColors.white,
    fontSize: AppFonts.size16,
    fontFamily: AppFonts.text,
    fontWeight: AppFonts.weightSemiBold,
  );

  static var blackBoldMonserrat_35 = TextStyle(
    color: AppColors.black,
    fontSize: AppFonts.size35,
    fontFamily: AppFonts.title,
    fontWeight: AppFonts.weightBold,
  );
  static var whiteBoldMonserrat_35 = TextStyle(
    color: AppColors.white,
    fontSize: AppFonts.size35,
    fontFamily: AppFonts.title,
    fontWeight: AppFonts.weightBold,
  );
  static var blackBoldMonserrat_24 = TextStyle(
    color: AppColors.black,
    fontSize: AppFonts.size24,
    fontFamily: AppFonts.title,
    fontWeight: AppFonts.weightBold,
  );
  static var whiteBoldMonserrat_24 = TextStyle(
    color: AppColors.white,
    fontSize: AppFonts.size24,
    fontFamily: AppFonts.title,
    fontWeight: AppFonts.weightBold,
  );
}

class AppFlatButton {
  static var styleShape =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0));
  static var stylePadding = EdgeInsets.symmetric(horizontal: 35, vertical: 10);
}

drawIconPlayers(Size size) {
  var iconPlayers = SvgPicture.asset(
    'assets/tennis-players.svg',
    semanticsLabel: 'players',
    width: size.width * 0.9,
    color: AppColors.blackOp25,
  );
  return iconPlayers;
}
