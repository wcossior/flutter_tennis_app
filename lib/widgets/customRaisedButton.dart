import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final SvgPicture icon;
  final Color color;
  final Color disabledColor;

  const CustomRaisedButton({
    Key key,
    @required this.child,
    @required this.onPressed,
    @required this.color,
    @required this.disabledColor,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: getProportionateScreenWidth(180.0),
        height: getProportionateScreenHeight(56),
        child: RaisedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                child,
                SizedBox(
                  width: 15.0,
                ),
                icon
              ],
            ),
            color: color,
            disabledColor: disabledColor,
            onPressed: onPressed),
      ),
    );
  }
}
