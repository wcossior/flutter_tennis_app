import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class SvgIconsApp {
  static var lock = SvgPicture.asset(
    'assets/icons/Lock.svg',
  );
  static var mail = SvgPicture.asset(
    'assets/icons/Mail.svg',
  );
  static var error = SvgPicture.asset(
    'assets/icons/Error.svg',
  );

  static var player = Container(
    margin: EdgeInsets.only(bottom: 20.0),
    alignment: Alignment.center,
    height: SizeConfig.screenHeight * 0.3,
    child: SvgPicture.asset('assets/icons/Player.svg'),
  );
  static var auth = Container(
    margin: EdgeInsets.only(bottom: 20.0),
    alignment: Alignment.center,
    height: SizeConfig.screenHeight * 0.25,
    child: SvgPicture.asset('assets/icons/Login.svg'),
  );
}
