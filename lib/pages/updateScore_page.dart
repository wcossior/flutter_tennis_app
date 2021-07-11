import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/game_bloc.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/customButton.dart';

class UpdateScorePage extends StatefulWidget {
  final Game game;

  UpdateScorePage({Key key, this.game}) : super(key: key);

  @override
  _UpdateScorePageState createState() => _UpdateScorePageState();
}

class _UpdateScorePageState extends State<UpdateScorePage> {
  GameBloc gameBloc = GameBloc();
  bool firstclick = false;

  final _formKey = GlobalKey<FormState>();
  List<dynamic> marcador = [];
  bool errorMarcador1erSet = false;
  bool errorMarcador2doSet = false;
  bool errorMarcador3erSet = false;
  TextEditingController set1player1Controller = TextEditingController();
  TextEditingController set1player2Controller = TextEditingController();
  TextEditingController set2player1Controller = TextEditingController();
  TextEditingController set2player2Controller = TextEditingController();
  TextEditingController set3player1Controller = TextEditingController();
  TextEditingController set3player2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    inicializarCamposDelFormulario();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _drawForm(),
          _loadingIndicator(gameBloc),
        ],
      ),
    );
  }

  void inicializarCamposDelFormulario() {
    set1player1Controller.text = widget.game.marcador[0]["jugador_uno"].toString();
    set1player2Controller.text = widget.game.marcador[0]["jugador_dos"].toString();
    set2player1Controller.text = widget.game.marcador[1]["jugador_uno"].toString();
    set2player2Controller.text = widget.game.marcador[1]["jugador_dos"].toString();
    if (widget.game.marcador.length == 3) {
      set3player1Controller.text = widget.game.marcador[2]["jugador_uno"].toString();
      set3player2Controller.text = widget.game.marcador[2]["jugador_dos"].toString();
    }
  }

  Widget _loadingIndicator(GameBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.streamLoading,
      builder: (context, snap) {
        return Container(
          child: Center(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(ColorsApp.green))
                : null,
          ),
        );
      },
    );
  }

  Widget _drawForm() {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SafeArea(
                child: Container(
                  height: getProportionateScreenHeight(30.0),
                ),
              ),
              _drawTitleAdd(),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawNamePlayers(),
              SizedBox(height: getProportionateScreenHeight(30.0)),
              _drawFieldScore1(gameBloc),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawFieldScore2(gameBloc),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawFieldScore3(gameBloc),
              SizedBox(height: getProportionateScreenHeight(35.0)),
              _drawButtonSave(gameBloc),
              SizedBox(height: getProportionateScreenHeight(30.0)),
            ],
          ),
        ),
      ),
    );
  }

  Row _drawNamePlayers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.game.jug1,
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Expanded(child: SizedBox(width: getProportionateScreenWidth(12.0))),
        Expanded(
          child: Text(
            widget.game.jug2,
            softWrap: true,
            maxLines: 2,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Widget _drawTitleAdd() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Actualizar marcador",
        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.green),
      ),
    );
  }

  Widget _drawFieldScore1(GameBloc bloc) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              controller: set1player1Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '1er set',
                hintText: 'Ej: 6',
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(30.0)),
          Expanded(
            child: TextFormField(
              controller: set1player2Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '1er set',
                hintText: 'Ej: 0',
              ),
            ),
          ),
        ]),
        if (errorMarcador1erSet)
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
            child: Text(
              "Error en marcador del 1er set",
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red[900]),
            ),
          ),
      ],
    );
  }

  Widget _drawFieldScore2(GameBloc bloc) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              controller: set2player1Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '2do set',
                hintText: 'Ej: 0',
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(30.0)),
          Expanded(
            child: TextFormField(
              controller: set2player2Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumber(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '2do set',
                hintText: 'Ej: 6',
              ),
            ),
          ),
        ]),
        if (errorMarcador2doSet)
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
            child: Text(
              "Error en marcador del 2do set",
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red[900]),
            ),
          ),
      ],
    );
  }

  Widget _drawFieldScore3(GameBloc bloc) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: TextFormField(
              controller: set3player1Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumberOrEmpty(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '3er set',
                hintText: 'Ej: 6',
              ),
            ),
          ),
          SizedBox(width: getProportionateScreenWidth(30.0)),
          Expanded(
            child: TextFormField(
              controller: set3player2Controller,
              keyboardType: TextInputType.number,
              validator: (value) => _validateNumberOrEmpty(value),
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: '3er set',
                hintText: 'Ej: 0',
              ),
            ),
          ),
        ]),
        if (errorMarcador3erSet)
          Padding(
            padding: EdgeInsets.only(top: getProportionateScreenHeight(8.0)),
            child: Text(
              "Error en marcador del 3er set",
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.red[900]),
            ),
          ),
      ],
    );
  }

  String _validateNumber(String value) {
    Pattern pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return 'Incorrecto';
    }
    return null;
  }

  String _validateNumberOrEmpty(String value) {
    Pattern pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Incorrecto';
    }
    return null;
  }

  // String _validateText(String value) {
  //   Pattern pattern = r'^[a-zA-Z\s]*$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
  //     return 'Texto invalido';
  //   }
  //   return null;
  // }
  bool _verificarMarcadorCorrecto(Map<String, int> marcadorSet) {
    List<dynamic> marcadoresCorrectos = [
      {"jugador_uno": 6, "jugador_dos": 0},
      {"jugador_uno": 6, "jugador_dos": 1},
      {"jugador_uno": 6, "jugador_dos": 2},
      {"jugador_uno": 6, "jugador_dos": 3},
      {"jugador_uno": 6, "jugador_dos": 4},
      {"jugador_uno": 7, "jugador_dos": 5},
      {"jugador_uno": 7, "jugador_dos": 6},
      {"jugador_uno": 0, "jugador_dos": 6},
      {"jugador_uno": 1, "jugador_dos": 6},
      {"jugador_uno": 2, "jugador_dos": 6},
      {"jugador_uno": 3, "jugador_dos": 6},
      {"jugador_uno": 4, "jugador_dos": 6},
      {"jugador_uno": 5, "jugador_dos": 7},
      {"jugador_uno": 6, "jugador_dos": 7},
    ];
    bool esCorrecto = false;

    for (var marcadorCorrecto in marcadoresCorrectos) {
      if (marcadorCorrecto["jugador_uno"] == marcadorSet["jugador_uno"] &&
          marcadorCorrecto["jugador_dos"] == marcadorSet["jugador_dos"]) {
        esCorrecto = true;
      }
    }
    return esCorrecto;
  }

  bool _verificarMarcadorCorrecto3set(Map<String, int> marcadorSet) {
    List<dynamic> marcadoresCorrectos = [
      {"jugador_uno": 6, "jugador_dos": 0},
      {"jugador_uno": 6, "jugador_dos": 1},
      {"jugador_uno": 6, "jugador_dos": 2},
      {"jugador_uno": 6, "jugador_dos": 3},
      {"jugador_uno": 6, "jugador_dos": 4},
      {"jugador_uno": 0, "jugador_dos": 6},
      {"jugador_uno": 1, "jugador_dos": 6},
      {"jugador_uno": 2, "jugador_dos": 6},
      {"jugador_uno": 3, "jugador_dos": 6},
      {"jugador_uno": 4, "jugador_dos": 6},
    ];
    bool esCorrecto = false;
    for (var marcadorCorrecto in marcadoresCorrectos) {
      if (marcadorCorrecto["jugador_uno"] == marcadorSet["jugador_uno"] &&
          marcadorCorrecto["jugador_dos"] == marcadorSet["jugador_dos"]) {
        esCorrecto = true;
      }
    }

    if ((marcadorSet["jugador_uno"] > 6 &&
            marcadorSet["jugador_dos"] < marcadorSet["jugador_uno"]) ||
        (marcadorSet["jugador_dos"] > 6 &&
            marcadorSet["jugador_uno"] < marcadorSet["jugador_dos"])) {
      esCorrecto = true;
    }

    return esCorrecto;
  }

  Widget _drawButtonSave(GameBloc bloc) {
    return CustomButton(
      child: Text(
        'Guardar',
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: firstclick == false
          ? () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                var primerSet = {
                  "jugador_uno": int.parse(set1player1Controller.text),
                  "jugador_dos": int.parse(set1player2Controller.text),
                };
                if (!_verificarMarcadorCorrecto(primerSet)) {
                  setState(() {
                    errorMarcador1erSet = true;
                  });
                } else {
                  setState(() {
                    errorMarcador1erSet = false;
                  });
                }
                var segundoSet = {
                  "jugador_uno": int.parse(set2player1Controller.text),
                  "jugador_dos": int.parse(set2player2Controller.text),
                };
                if (!_verificarMarcadorCorrecto(segundoSet)) {
                  setState(() {
                    errorMarcador2doSet = true;
                  });
                } else {
                  setState(() {
                    errorMarcador2doSet = false;
                  });
                }
                var tercerSet;
                if (set3player1Controller.text != "" && set3player2Controller.text != "") {
                  tercerSet = {
                    "jugador_uno": int.parse(set3player1Controller.text),
                    "jugador_dos": int.parse(set3player2Controller.text),
                  };
                  if (!_verificarMarcadorCorrecto3set(tercerSet)) {
                    setState(() {
                      errorMarcador3erSet = true;
                    });
                  } else {
                    setState(() {
                      errorMarcador3erSet = false;
                    });
                  }
                }
                if (!errorMarcador1erSet && !errorMarcador2doSet) {
                  if (set3player1Controller.text != "" && set3player2Controller.text != "") {
                    if (!errorMarcador3erSet) {
                      setState(() {
                        firstclick = true;
                      });
                      marcador.add(primerSet);
                      marcador.add(segundoSet);
                      marcador.add(tercerSet);
                      KeyboardUtil.hideKeyboard(context);
                      await bloc.updateScores(widget.game.id, marcador);
                      String text = bloc.valueMessage;
                      var mssg = _showMessage(context, text);
                      await mssg.show();
                      Navigator.pop(context);
                    }
                  } else {
                    setState(() {
                      firstclick = true;
                    });
                    marcador.add(primerSet);
                    marcador.add(segundoSet);
                    KeyboardUtil.hideKeyboard(context);
                    await bloc.updateScores(widget.game.id, marcador);
                    String text = bloc.valueMessage;
                    var mssg = _showMessage(context, text);
                    await mssg.show();
                    Navigator.pop(context);
                  }
                }
              }
            }
          : null,
    );
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
