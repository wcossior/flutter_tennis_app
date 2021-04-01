import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconsApp{
  static var arrowRight = SvgPicture.asset(
  'assets/arrow-right.svg',
  semanticsLabel: 'arrow-right',
  color: ColorsApp.white,
  width: getProportionateScreenWidth(20.0),
);
}