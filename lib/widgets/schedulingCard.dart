import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/models/scheduling_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class SchedulingCard extends StatefulWidget {
  final Event event;
  SchedulingCard({Key key, this.event}) : super(key: key);

  @override
  _SchedulingCardState createState() => _SchedulingCardState();
}

class _SchedulingCardState extends State<SchedulingCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(7.0),
          bottomRight: Radius.circular(7.0),
        ),
      ),
      child: _drawInfoCard(widget.event),
    );
  }

  Widget _drawInfoCard(Event event) {
    return Column(
      children: [
        _drawHeaderCard(event),
        Divider(thickness: 1.2, color: ColorsApp.greyObscured),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawPlayers(event),
        SizedBox(height: getProportionateScreenHeight(8.0)),
      ],
    );
  }

  Widget _drawPlayers(Event event) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(8.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(12.0),
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _drawPlayer1(event),
            Expanded(flex: 1, child: SvgIconsApp.rackets),
            _drawPlayer2(event),
          ],
        ),
      ),
    );
  }

  Widget _drawPlayer2(Event event) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(height: 6.0),
              Text(
                event.jugador2,
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            event.pertenece2,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _drawPlayer1(Event event) {
    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgIconsApp.avatarPlayer,
              SizedBox(height: 6.0),
              Text(
                event.jugador1,
                softWrap: true,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            event.pertenece1,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _drawHeaderCard(Event event) {
    return Container(
      padding: EdgeInsets.only(
        top: getProportionateScreenHeight(12.0),
        left: getProportionateScreenWidth(15.0),
        right: getProportionateScreenWidth(15.0),
        bottom: getProportionateScreenWidth(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.categoria,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "Cancha " + event.cancha,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
          ),
        ],
      ),
    );
  }
}
