import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;

  const CustomButton({
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
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
          color: ColorsApp.orange,
          disabledColor: ColorsApp.blueObscuredOp50,
          child: child,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
