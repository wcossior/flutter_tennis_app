import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/game_bloc.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/pages/fullTime_page.dart';
import 'package:flutter_app_tenis/pages/updateScore_page.dart';
import 'package:flutter_app_tenis/preferences/userPreferences.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';

class DetailGamePage extends StatefulWidget {
  final Game game;
  final String idCategoria;
  final String typeInfo;
  DetailGamePage({Key key, @required this.game, @required this.idCategoria, @required this.typeInfo})
      : super(key: key);

  @override
  _DetailGamePageState createState() => _DetailGamePageState();
}

class _DetailGamePageState extends State<DetailGamePage> {
  GameBloc gameBloc = GameBloc();
  bool firstClic = false;
  Game partido;
  final prefs = new UserPreferences();

  @override
  void initState() {
    setState(() {
      partido = widget.game;
    });
    super.initState();
  }

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
        child: Stack(children: [_drawContent(context), _loadingIndicator(gameBloc)]),
      ),
      floatingActionButton: partido.partidoTerminado && prefs.user["rol"] == "Arbitro"
          ? FloatingActionButton(
              heroTag: "actualizar marcador",
              child: SvgIconsApp.formAdd,
              onPressed: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => UpdateScorePage(
                      game: partido,
                    ),
                  ),
                )
                    .then((_) async {
                  Game p = await gameBloc.getAGame(widget.idCategoria, widget.game.id, widget.typeInfo);
                  setState(() {
                    partido = p;
                  });
                });
              },
            )
          : Container(),
    );
  }

  Widget _loadingIndicator(GameBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.streamLoading,
      builder: (context, snap) {
        return Container(
          child: Center(
            child: (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
          ),
        );
      },
    );
  }

  Widget _drawContent(BuildContext context) {
    return Column(
      children: [
        _drawTitle(context),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Información:",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        _drawInfoGame(context),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Resultado general:",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        _drawGeneralScore(context),
        if (!partido.partidoTerminado && partido.jug1 != "BYE" && partido.jug2 != "BYE")
          SizedBox(height: getProportionateScreenHeight(12.0)),
        if (!partido.partidoTerminado &&
            partido.jug1 != "BYE" &&
            partido.jug2 != "BYE" &&
            prefs.user["rol"] == "Arbitro")
          _finishGame(),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        SvgIconsApp.courtDetail,
        SizedBox(height: getProportionateScreenHeight(12.0)),
        _drawClubs(context),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "Resultado en sets:",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        Expanded(child: _drawSetsResults(context)),
      ],
    );
  }

  Container _drawClubs(BuildContext context) {
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
          Expanded(
            child: Text(
              partido.club1,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
            ),
          ),
          Expanded(child: SizedBox(width: getProportionateScreenWidth(12.0))),
          Expanded(
            child: Text(
              partido.club2,
              softWrap: true,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawTitle(BuildContext context) {
    return Text(
      _getTitleGame(partido),
      style: Theme.of(context).textTheme.headline2.copyWith(
            color: ColorsApp.blueObscured,
          ),
    );
  }

  String _getTitleGame(Game game) {
    if (game.etapa == "") {
      return "Partido de grupo " + game.nombre;
    } else {
      return "Partido de " + game.etapa;
    }
  }

  Container _drawInfoGame(BuildContext context) {
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Hora inicio " + partido.horaInicio,
                style: partido.horaInicioMv == "Hora se mantiene"
                    ? Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50)
                    : Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: ColorsApp.blueObscuredOp50, decoration: TextDecoration.lineThrough),
              ),
              Text(
                "Cancha " + partido.nroCancha.toString(),
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(12.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (partido.horaInicioMv != "Hora se mantiene")
                Text(
                  "Hora inicio " + partido.horaInicioMv,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
                ),
              Text(
                "Hora fin " + partido.horaFin,
                style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _drawGeneralScore(BuildContext context) {
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
        children: [
          _drawPlayer(partido.jug1, partido.generalScore1, partido.generalScore2),
          SizedBox(width: getProportionateScreenWidth(8.0)),
          _drawScoresPlayers(partido.generalScore1, partido.generalScore2),
          Expanded(
            flex: 1,
            child: Text(
              ":",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.blueObscuredOp50),
            ),
          ),
          _drawScoresPlayers(partido.generalScore2, partido.generalScore1),
          SizedBox(width: getProportionateScreenWidth(8.0)),
          _drawPlayer(partido.jug2, partido.generalScore2, partido.generalScore1),
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
      style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.blueObscuredOp50),
    );
  }

  Widget _drawWinnerScore(int score) {
    return Text(score.toString(), style: Theme.of(context).textTheme.headline2);
  }

  Widget _finishGame() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      color: ColorsApp.orange,
      disabledColor: ColorsApp.blueObscuredOp50,
      child: Text(
        'Finalizar partido',
        style: Theme.of(context).textTheme.button.copyWith(
              fontSize: getProportionateScreenHeight(14.0),
            ),
      ),
      onPressed: !partido.partidoTerminado
          ? () {
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => FullTimePage(
                    game: partido,
                  ),
                ),
              )
                  .then((_) async {
                Game p = await gameBloc.getAGame(widget.idCategoria, widget.game.id, widget.typeInfo);
                setState(() {
                  partido = p;
                });
              });
              // _areYouSureToFinish();
            }
          : null,
    );
  }

  Widget _drawSetsResults(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsApp.greyObscured,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
      ),
      child: _drawSets(),
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
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          _drawIconWin(),
          Text(
            name,
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
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
    return Expanded(
      flex: 3,
      child: Text(
        name,
        softWrap: true,
        maxLines: 2,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
      ),
    );
  }

  Widget _drawSets() {
    List<dynamic> marcador = partido.marcador;

    if (marcador.isEmpty) {
      return Center(child: Text("No hay sets"));
    } else {
      return _drawListSet(marcador);
    }
  }

  Widget _drawListSet(List<dynamic> data) {
    return ListView(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.055,
        right: SizeConfig.screenWidth * 0.055,
        top: SizeConfig.screenHeight * 0.010,
      ),
      children: _readList(data),
    );
  }

  List<Widget> _readList(List<dynamic> data) {
    final List<Widget> drawnSets = [];
    final setList = data;
    List<String> tituloSet = ["Primer set", "Segundo set", "Tercer set"];
    int index = 0;
    setList.forEach((item) {
      final widgetTemp = _drawSet(item, tituloSet[index]);
      drawnSets.add(widgetTemp);
      index++;
    });
    return drawnSets;
  }

  Widget _drawSet(dynamic setItem, String titulo) {
    return Card(
      margin: EdgeInsets.only(
        bottom: getProportionateScreenHeight(10.0),
        top: getProportionateScreenHeight(10.0),
      ),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12.0)),
        child: Column(
          children: [
            _drawTitleSet(titulo),
            Divider(),
            _drawScoreSet(setItem["jugador_uno"], setItem["jugador_dos"]),
          ],
        ),
      ),
    );
  }

  Widget _drawTitleSet(String setTitle) {
    return Text(
      setTitle,
      style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.green),
    );
  }

  Widget _drawScoreSet(int score1, int score2) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15.0),
        vertical: getProportionateScreenHeight(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              SvgIconsApp.ball,
              SizedBox(width: 6.0),
              Text(
                score1.toString(),
                style: score1 > score2
                    ? Theme.of(context).textTheme.bodyText1
                    : Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
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
                    : Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
