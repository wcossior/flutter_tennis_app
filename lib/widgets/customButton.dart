import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';

class CustomRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CustomRaisedButton({
    Key key,
    @required this.child,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: getProportionateScreenHeight(56),
        child: RaisedButton(
          splashColor: Colors.grey,
          elevation: 5.0,
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
