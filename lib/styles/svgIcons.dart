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

  static var courtDetail = SvgPicture.asset(
    'assets/icons/CourtDetail.svg',
    width: getProportionateScreenWidth(100.0),
    height: getProportionateScreenHeight(100.0),
  );

  static var playerDetail = SvgPicture.asset(
    'assets/icons/PlayerDetail.svg',
    width: getProportionateScreenWidth(35.0),
    height: getProportionateScreenHeight(35.0),
    color: ColorsApp.orange,
  );

  static var player2Detail = SvgPicture.asset(
    'assets/icons/Player2Detail.svg',
    width: getProportionateScreenWidth(35.0),
    height: getProportionateScreenHeight(35.0),
    color: ColorsApp.orange,
  );

  static var ball = SvgPicture.asset(
    'assets/icons/TennisBall.svg',
    width: getProportionateScreenWidth(16.0),
    height: getProportionateScreenHeight(16.0),
  );

  static var winner = ClipRRect(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(7.0), bottomRight: Radius.circular(7.0)),
    child: SvgPicture.asset(
      'assets/icons/Winner.svg',
      fit: BoxFit.cover,
      width: getProportionateScreenWidth(100.0),
      height: getProportionateScreenHeight(100.0),
    ),
  );

  static var tournament = Container(
    padding: EdgeInsets.all(getProportionateScreenWidth(6.0)),
    height: getProportionateScreenHeight(65.0),
    width: getProportionateScreenWidth(75.0),
    child: SvgPicture.asset('assets/icons/Tournament.svg'),
    decoration: BoxDecoration(
      color: ColorsApp.green,
      shape: BoxShape.circle,
    ),
  );

  static var winners = Container(
    padding: EdgeInsets.all(getProportionateScreenWidth(6.0)),
    height: getProportionateScreenHeight(75.0),
    width: getProportionateScreenWidth(85.0),
    child: SvgPicture.asset('assets/icons/Winners.svg'),
    decoration: BoxDecoration(
      color: ColorsApp.green,
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
    width: getProportionateScreenWidth(16.0),
    child: SvgPicture.asset(
      'assets/icons/Court.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var players = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/Group.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var title = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/Title.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var avatarPlayer = SvgPicture.asset(
    'assets/icons/Avatar.svg',
    height: getProportionateScreenHeight(22.0),
    width: getProportionateScreenWidth(22.0),
    color: ColorsApp.blueObscured,
  );

  static var type = Container(
    height: getProportionateScreenHeight(19.0),
    width: getProportionateScreenWidth(19.0),
    child: SvgPicture.asset(
      'assets/icons/Type.svg',
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

  static var detail = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Detail.svg',
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

  static var category = Container(
    height: getProportionateScreenHeight(25.0),
    width: getProportionateScreenWidth(25.0),
    child: SvgPicture.asset(
      'assets/icons/Category.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var schedule = Container(
    height: getProportionateScreenHeight(20.0),
    width: getProportionateScreenWidth(20.0),
    child: SvgPicture.asset(
      'assets/icons/Schedule.svg',
      color: ColorsApp.blueObscured,
    ),
  );

  static var logout = Container(
    height: getProportionateScreenHeight(18.0),
    width: getProportionateScreenWidth(20.0),
    child: SvgPicture.asset(
      'assets/icons/Logout.svg',
      color: ColorsApp.blueObscured,
    ),
  );
}
