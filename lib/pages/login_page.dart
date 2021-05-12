import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/login_bloc.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/customButton.dart';
import 'package:flutter_app_tenis/widgets/customSurfixIcon.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();
  bool firstClick = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ColorsApp.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _drawContent(),
          _loadingIndicator(loginBloc),
        ],
      ),
      bottomNavigationBar: _drawOptionCreateAccount(),
    );
  }

  Widget _drawOptionCreateAccount() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(15.0),
      ),
      width: SizeConfig.screenWidth * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _drawDontYouHaveAnyAccountYet(),
          SizedBox(width: 10.0),
          _drawButtonSignUp(),
        ],
      ),
    );
  }

  Text _drawDontYouHaveAnyAccountYet() {
    return Text(
      '¿No tienes cuenta?',
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  GestureDetector _drawButtonSignUp() {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage())),
      child: Text(
        "Registrarse",
        style: Theme.of(context).textTheme.bodyText2.copyWith(color: ColorsApp.orange),
      ),
    );
  }

  Widget _drawContent() {
    return SingleChildScrollView(
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: getProportionateScreenHeight(15.0),
              ),
            ),
            SvgIconsApp.player,
            _drawTitleLogin(),
            SizedBox(height: 25.0),
            _drawFieldEmail(loginBloc),
            SizedBox(height: 25.0),
            _drawFieldPassword(loginBloc),
            SizedBox(height: 45.0),
            _drawButtonLogin(loginBloc),
            SizedBox(height: getProportionateScreenHeight(20.0)),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator(LoginBloc bloc) {
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

  Widget _drawTitleLogin() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Inicia Sesión",
        style: Theme.of(context).textTheme.headline1.copyWith(color: ColorsApp.green),
      ),
    );
  }

  Widget _drawFieldEmail(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.streamEmail,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.sinkEmail,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
              labelText: 'Correo electrónico',
              hintText: 'Ingresa tu correo electrónico',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawFieldPassword(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.streamPassword,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            obscureText: true,
            onChanged: bloc.sinkPassword,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawButtonLogin(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.streamSubmitValid,
      builder: (context, snapshot) {
        return CustomButton(
          child: Text(
            'Iniciar sesión',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: !snapshot.hasData
              ? null
              : !firstClick
                  ? () async {
                      setState(() => firstClick = true);
                      KeyboardUtil.hideKeyboard(context);
                      String text = await bloc.submit();
                      if (text != "Inicio exitoso") {
                        var message = _showMessage(context, text);
                        await message.show();
                      }
                    }
                  : null,
        );
      },
    );
  }

  AwesomeDialog _showMessage(BuildContext context, String mssg) {
    setState(() {
      firstClick = false;
    });
    return AwesomeDialog(
      context: context,
      dialogType: mssg.contains("error") ? DialogType.ERROR : DialogType.WARNING,
      animType: AnimType.SCALE,
      title: mssg,
      desc: "",
      autoHide: Duration(seconds: 4),
    );
  }
}
