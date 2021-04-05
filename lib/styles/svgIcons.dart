import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class SvgIconsApp {
  static var player = Container(
    margin: EdgeInsets.only(bottom: 20.0),
    alignment: Alignment.center,
    height: SizeConfig.screenHeight * 0.35,
    child: SvgPicture.asset('assets/icons/Player.svg'),
  );

  static var winner = Container(
    padding: EdgeInsets.all(getProportionateScreenWidth(6.0)),
    height: getProportionateScreenHeight(65.0),
    width: getProportionateScreenWidth(75.0),
    child: SvgPicture.asset('assets/icons/Winner.svg'),
    decoration: new BoxDecoration(
      color: ColorsApp.orange,
      shape: BoxShape.circle,
    ),
  );

  static var bell = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Bell.svg',
      color: ColorsApp.white,
    ),
  );

  static var calendarStart = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/CalendarStart.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var calendarEnd = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/CalendarEnd.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var court = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/Court.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var trophy = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Trophy.svg',
      color: ColorsApp.white,
    ),
  );

  static var group = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Group.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var playoffs = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Playoffs.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var logout = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Logout.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var user = Container(
    height: getProportionateScreenHeight(35.0),
    width: getProportionateScreenWidth(35.0),
    child: SvgPicture.asset(
      'assets/icons/User.svg',
      color: ColorsApp.blueObscured,
    ),
  );
}
