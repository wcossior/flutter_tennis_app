import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/game_bloc.dart';
import 'package:flutter_app_tenis/models/game_model.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/customButton.dart';
import 'package:flutter_app_tenis/widgets/customSurfixIcon.dart';

class FormNewSetPage extends StatefulWidget {
  final Game game;

  FormNewSetPage({Key key, this.game}) : super(key: key);

  @override
  _FormNewSetPageState createState() => _FormNewSetPageState();
}

class _FormNewSetPageState extends State<FormNewSetPage> {
  GameBloc gameBloc = GameBloc();

  final _formKey = GlobalKey<FormState>();

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
              SizedBox(height: getProportionateScreenHeight(30.0)),
              _drawFieldNroSet(gameBloc),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawFieldScore1(gameBloc),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawFieldScore2(gameBloc),
              SizedBox(height: getProportionateScreenHeight(20.0)),
              _drawButtonSave(gameBloc),
              SizedBox(height: getProportionateScreenHeight(30.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawTitleAdd() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Nuevo set",
        style: Theme.of(context).textTheme.headline2.copyWith(color: ColorsApp.green),
      ),
    );
  }

  Widget _drawFieldNroSet(GameBloc bloc) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.text,
        onSaved: bloc.sinkNroSet,
        validator: (value) => _validateText(value),
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Avatar.svg"),
            labelText: 'Número de set',
            hintText: "Ejemplo: Primer set"),
      ),
    );
  }

  Widget _drawFieldScore1(GameBloc bloc) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) => _validateNumber(value),
        onSaved: bloc.sinkScore1,
        decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Avatar.svg"),
            labelText: 'Score de ${widget.game.jug1}',
            hintText: 'Ejemplo: 30'),
      ),
    );
  }

  Widget _drawFieldScore2(GameBloc bloc) {
    return Container(
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: (value) => _validateNumber(value),
        onSaved: bloc.sinkScore2,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Avatar.svg"),
          labelText: 'Score de ${widget.game.jug2}',
          hintText: 'Ejemplo: 40',
        ),
      ),
    );
  }

  String _validateNumber(String value) {
    Pattern pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return 'Número invalido';
    }
    return null;
  }

  String _validateText(String value) {
    Pattern pattern = r'^[a-zA-Z\s]*$';
    RegExp regExp = new RegExp(pattern);
    if (value == null || value.isEmpty || !regExp.hasMatch(value)) {
      return 'Texto invalido';
    }
    return null;
  }

  Widget _drawButtonSave(GameBloc bloc) {
    return CustomButton(
      child: Text(
        'Guardar',
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          KeyboardUtil.hideKeyboard(context);
          await bloc.newSet(widget.game.id);
          String text = bloc.valueMessage;
          var mssg = _showMessage(context, text);
          await mssg.show();
          Navigator.pop(context);
        }
      },
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
