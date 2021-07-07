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
  bool terminadoColor;

  @override
  void initState() {
    super.initState();
    setState(() {
      terminadoColor = widget.event.partidoTerminado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(18.0)),
      color: terminadoColor==true?ColorsApp.greyObscured:Colors.white,
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
        Text(
          event.categoria,
          style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
        ),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawPlayers(event),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawScorePlayers(event),
        SizedBox(height: getProportionateScreenHeight(8.0)),
        _drawStatusEvent(event.partidoTerminado),
        SizedBox(height: getProportionateScreenHeight(8.0)),
      ],
    );
  }

  Row _drawScorePlayers(Event event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        event.ganador == "1"
            ? _drawScoreWinnerPlayer(event.marcador, event.ganador)
            : _drawScoreLoserPlayer(event.marcador, event.ganador),
        event.ganador == "2"
            ? _drawScoreWinnerPlayer(event.marcador, event.ganador)
            : _drawScoreLoserPlayer(event.marcador, event.ganador),
      ],
    );
  }

  Widget _drawScoreLoserPlayer(List<dynamic> score, String ganador) {
    var perdedor;
    if (ganador == "1")
      perdedor = "2";
    else
      perdedor = "1";
    return score.isEmpty
        ? Text(
            "?",
            style: Theme.of(context).textTheme.bodyText1,
          )
        : _drawScoreLoser(score, perdedor);
  }

  Widget _drawScoreWinnerPlayer(List<dynamic> score, String ganador) {
    return score.isEmpty
        ? Text(
            "?",
            style: Theme.of(context).textTheme.bodyText1,
          )
        : _drawScoreWinner(score, ganador);
  }

  Widget _drawScoreLoser(List<dynamic> score, String player) {
    String marcador = "";
    for (var i = 0; i < score.length; i++) {
      if (player == "1")
        marcador = marcador + (i == 0 ? " " : ", ") + score[i]["jugador_uno"].toString();
      else
        marcador = marcador + (i == 0 ? " " : ", ") + score[i]["jugador_dos"].toString();
    }
    return Text(
      marcador,
      style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w500),
    );
  }

  Widget _drawScoreWinner(List<dynamic> score, String player) {
    String marcador = "";
    for (var i = 0; i < score.length; i++) {
      if (player == "1")
        marcador = marcador + (i == 0 ? " " : ", ") + score[i]["jugador_uno"].toString();
      else
        marcador = marcador + (i == 0 ? " " : ", ") + score[i]["jugador_dos"].toString();
    }
    return Text(
      marcador,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  Widget _drawStatusEvent(bool status) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(6.0),
        vertical: getProportionateScreenHeight(3.0),
      ),
      child: Text(
        status == true ? "Partido finalizado" : "Partido no finalizado",
        style: Theme.of(context).textTheme.bodyText1.copyWith(
              color: ColorsApp.white,
              fontSize: 10.0,
            ),
      ),
      decoration: BoxDecoration(
        color: status == true ? ColorsApp.orange : ColorsApp.green,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
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
          SvgIconsApp.avatarPlayer,
          SizedBox(height: 6.0),
          Text(
            event.jugador2,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: event.ganador == "2"
                ? Theme.of(context).textTheme.bodyText1
                : Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300),
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
          SvgIconsApp.avatarPlayer,
          SizedBox(height: 6.0),
          Text(
            event.jugador1,
            softWrap: true,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: event.ganador == "1"
                ? Theme.of(context).textTheme.bodyText1
                : Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.w300),
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
          Row(
            children: [
              Text(
                "Cambio de hora: ",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: ColorsApp.blueObscuredOp50),
              ),
              Text(
                event.horaInicioMviborita,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          Text(
            "Cancha " + event.cancha,
            style:
                Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
          ),
        ],
      ),
    );
  }
}
