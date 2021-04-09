import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class DetailGamePage extends StatefulWidget {
  final Game game;
  DetailGamePage({Key key, @required this.game}) : super(key: key);

  @override
  _DetailGamePageState createState() => _DetailGamePageState();
}

class _DetailGamePageState extends State<DetailGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles", style: Theme.of(context).textTheme.subtitle2),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.075,
          vertical: SizeConfig.screenHeight * 0.025,
        ),
        child: Column(
          children: [
            _drawTitle(context),
            SizedBox(height: getProportionateScreenHeight(8.0)),
            _drawScore(context),
            SizedBox(height: getProportionateScreenHeight(12.0)),
            SvgIconsApp.courtDetail,
            SizedBox(height: getProportionateScreenHeight(12.0)),
            _drawDateAndCourt(context),
            SizedBox(height: getProportionateScreenHeight(12.0)),
            _drawInfo(widget.game),
          ],
        ),
      ),
    );
  }

  Container _drawDateAndCourt(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsApp.greyObscured,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.game.horaInicio,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "Cancha " + widget.game.nroCancha.toString(),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  Widget _drawInfo(Game game) {
    return Card(
      margin: EdgeInsets.only(
          bottom: getProportionateScreenHeight(18.0), top: getProportionateScreenHeight(18.0)),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Column(
        children: [
          _drawTitleSet("Primer set"),
          _drawScoreSet(40, 15),
          _drawTitleSet("Segundo set"),
          _drawScoreSet(30, 40),
          _drawTitleSet("Tercer set"),
          _drawScoreSet(40, 30),
        ],
      ),
    );
  }

  Widget _drawScoreSet(int score1, int score2) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15.0),
        vertical: getProportionateScreenHeight(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgIconsApp.ball,
              SizedBox(width: 6.0),
              Text(
                score1.toString(),
                style: score1 > score2
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Row(
            children: [
              SvgIconsApp.ball,
              SizedBox(width: 6.0),
              Text(
                score2.toString(),
                style: score2 > score1
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawTitleSet(String setTitle) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15.0),
        vertical: getProportionateScreenHeight(12.0),
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: setTitle.contains("Primer")
              ? BorderRadius.only(
                  topLeft: Radius.circular(7.0),
                  topRight: Radius.circular(7.0),
                )
              : null,
          color: ColorsApp.blueObscured),
      child: Text(
        setTitle,
        style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.white),
      ),
    );
  }

  Widget _drawPlayer(String name, int score, int anotherScore) {
    if (score > anotherScore) {
      return _drawWinnerPlayer(name, score);
    } else {
      return _drawLoserPlayer(name, score);
    }
  }

  Widget _drawWinnerPlayer(String name, int score) {
    return Column(
      children: [
        _drawIconWin(),
        Text(
          _getNamePlayer(name),
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Widget _drawIconWin() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(6.0),
        vertical: getProportionateScreenHeight(3.0),
      ),
      child: Text(
        "Ganó",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: ColorsApp.white,
              fontSize: 10.0,
            ),
      ),
      decoration: BoxDecoration(
        color: ColorsApp.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
    );
  }

  Widget _drawLoserPlayer(String name, int score) {
    return Text(
      _getNamePlayer(name),
      style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
    );
  }

  Widget _drawScore(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsApp.greyObscured,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _drawPlayer(widget.game.jug1, widget.game.scoreJugador1, widget.game.scoreJugador2),
          Row(
            children: [
              _drawScoresPlayers(widget.game.scoreJugador1, widget.game.scoreJugador2),
              Text(" : ", style: Theme.of(context).textTheme.headline2),
              _drawScoresPlayers(widget.game.scoreJugador2, widget.game.scoreJugador1),
            ],
          ),
          _drawPlayer(widget.game.jug2, widget.game.scoreJugador2, widget.game.scoreJugador1),
        ],
      ),
    );
  }

  Widget _drawScoresPlayers(int score1, int score2) {
    if (score1 > score2) {
      return _drawWinnerScore(score1);
    } else {
      return _drawLoserScore(score1);
    }
  }

  Widget _drawLoserScore(int score) {
    return Text(
      score.toString(),
      style: Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.w400),
    );
  }

  Widget _drawWinnerScore(int score) {
    return Text(score.toString(), style: Theme.of(context).textTheme.headline2);
  }

  Widget _drawTitle(BuildContext context) {
    return Text(
      _getTitleGame(widget.game),
      style: Theme.of(context).textTheme.headline2.copyWith(
            color: ColorsApp.blueObscured,
          ),
    );
  }

  String _getNamePlayer(String name) {
    if (name.length > 12) {
      return name.substring(0, 13) + "...";
    } else {
      return name;
    }
  }

  String _getTitleGame(Game game) {
    if (game.etapa == "") {
      return "Partido de grupo " + game.nombre;
    } else {
      return "Partido de " + game.etapa;
    }
  }
}
