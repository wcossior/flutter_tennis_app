import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/game_bloc.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/models/set_model.dart';
import 'package:flutter_app_tenis/pages/formNewSet_page.dart';
import 'package:flutter_app_tenis/pages/formUpdateSet_page.dart';
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
  GameBloc gameBloc = GameBloc();
  int score1;
  int score2;
  bool firstClic = false;

  @override
  void initState() {
    super.initState();
    gameBloc.getSets(widget.game.id);
    setState(() {
      score1 = widget.game.scoreJugador1;
      score2 = widget.game.scoreJugador2;
    });
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
      floatingActionButton: FloatingActionButton(
          heroTag: "añadir set",
          child: SvgIconsApp.formAdd,
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => FormNewSetPage(
                      game: widget.game,
                    ),
                  ),
                )
                .then((_) async => gameBloc.getSets(widget.game.id));
          }),
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
        SizedBox(height: getProportionateScreenHeight(12.0)),
        _finishGame(),
        SizedBox(height: getProportionateScreenHeight(12.0)),
        SvgIconsApp.courtDetail,
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
        SizedBox(height: getProportionateScreenHeight(12.0)),
      ],
    );
  }

  Widget _drawTitle(BuildContext context) {
    return Text(
      _getTitleGame(widget.game),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.game.horaInicio,
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
          ),
          Text(
            "Cancha " + widget.game.nroCancha.toString(),
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorsApp.blueObscuredOp50),
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
          _drawPlayer(widget.game.jug1, score1, score2),
          _drawScoresPlayers(score1, score2),
          Expanded(
            flex: 1,
            child: Text(
              ":",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.blueObscuredOp50),
            ),
          ),
          _drawScoresPlayers(score2, score1),
          _drawPlayer(widget.game.jug2, score2, score1),
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
      onPressed: !firstClic
          ? () {
              setState(() {
                firstClic = true;
              });
              _areYouSureToFinish();
            }
          : null,
    );
  }

  void _areYouSureToFinish() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      headerAnimationLoop: true,
      animType: AnimType.BOTTOMSLIDE,
      showCloseIcon: false,
      closeIcon: Icon(Icons.close_fullscreen_outlined),
      title: '¿Finalizar encuentro?',
      desc: 'Al finalizar el partido se publicará el resultado general',
      btnOkText: "Si",
      btnOkColor: ColorsApp.orange,
      btnCancelText: "No",
      btnCancelColor: ColorsApp.green,
      btnCancelOnPress: () {},
      btnOkOnPress: () async {
        await gameBloc.getGeneralResult(widget.game.id);
        setState(() {
          score1 = gameBloc.scoreJugador1;
          score2 = gameBloc.scoreJugador2;
          firstClic = true;
        });
        String text = gameBloc.valueMessage;
        var mssg = _showMessage(context, text);
        setState(() {
          firstClic = false;
        });
        await mssg.show();
      },
    )..show();
  }

  Widget _drawSetsResults(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: getProportionateScreenWidth(12.0)),
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
          Container(
            padding: EdgeInsets.only(
              left: SizeConfig.screenWidth * 0.055,
              right: SizeConfig.screenWidth * 0.055,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _drawPlayer(widget.game.jug1, widget.game.scoreJugador1, widget.game.scoreJugador2),
                Expanded(flex: 2, child: Container()),
                _drawPlayer(widget.game.jug2, widget.game.scoreJugador2, widget.game.scoreJugador1),
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenWidth(12.0)),
          Expanded(child: _drawSets()),
        ],
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
    return StreamBuilder<List<TennisSet>>(
      stream: gameBloc.streamSetTennis,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.isNotEmpty) {
          return _drawListSet(snapshot.data);
        }
        if (snapshot.data == null) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Center(child: Text("No hay sets"));
        }
      },
    );
  }

  Widget _drawListSet(List<TennisSet> data) {
    return ListView(
      padding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.055,
        right: SizeConfig.screenWidth * 0.055,
        top: SizeConfig.screenHeight * 0.025,
      ),
      children: _readList(data),
    );
  }

  List<Widget> _readList(List<TennisSet> data) {
    final List<Widget> drawnSets = [];
    final setList = data;

    setList.forEach((item) {
      final widgetTemp = _drawSet(item);
      drawnSets.add(widgetTemp);
    });
    return drawnSets;
  }

  Widget _drawSet(TennisSet setItem) {
    return Card(
      margin: EdgeInsets.only(
          bottom: getProportionateScreenHeight(18.0), top: getProportionateScreenHeight(18.0)),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(12.0)),
        child: Column(
          children: [
            _drawTitleSet(setItem.nroSet),
            Divider(),
            _drawScoreSet(setItem.scoreJug1, setItem.scoreJug2),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _updateSet(widget.game, setItem),
                _deleteSet(widget.game, setItem),
              ],
            ),
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

  Row _updateSet(Game game, TennisSet setItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIconsApp.edit,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => FormUpdateSetPage(
                      game: game,
                      setTennis: setItem,
                    ),
                  ),
                )
                .then((_) async => gameBloc.getSets(widget.game.id));
          },
          child: Text(
            "Editar",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        )
      ],
    );
  }

  Row _deleteSet(Game game, TennisSet setItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgIconsApp.trash,
        SizedBox(width: 8.0),
        GestureDetector(
          onTap: () => _areYouSureToDelete(setItem),
          child: Text(
            "Eliminar",
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: ColorsApp.orange,
                  fontWeight: FontWeight.w700,
                ),
          ),
        )
      ],
    );
  }

  void _areYouSureToDelete(TennisSet setItem) {
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        headerAnimationLoop: true,
        animType: AnimType.BOTTOMSLIDE,
        showCloseIcon: false,
        closeIcon: Icon(Icons.close_fullscreen_outlined),
        title: 'Eliminar set',
        desc: '¿Esta seguro de eliminar?',
        btnOkText: "Si",
        btnOkColor: ColorsApp.orange,
        btnCancelText: "No",
        btnCancelColor: ColorsApp.green,
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          await gameBloc.deleteSet(setItem.id);
          String text = gameBloc.valueMessage;
          var mssg = _showMessage(context, text);
          gameBloc.getSets(widget.game.id);
          await mssg.show();
        })
      ..show();
  }

  AwesomeDialog _showMessage(BuildContext context, String mssg) {
    return AwesomeDialog(
      context: context,
      dialogType: mssg.contains("error") ? DialogType.ERROR : DialogType.SUCCES,
      animType: AnimType.SCALE,
      title: mssg,
      desc: "",
      autoHide: Duration(seconds: 4),
    );
  }
}
