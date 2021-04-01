import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/login_bloc.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';
import 'package:flutter_app_tenis/styles/backgrounds.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/widgets/CustomRaisedButton.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();
  bool firstClick = false;
  String message = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _drawBackground(),
          _drawContent(),
          _loadingIndicator(loginBloc),
        ],
      ),
      bottomNavigationBar: _drawOptionCreateAccount(),
    );
  }

  void _showMessageAlert(String message) {
    String isValidData = "Inicio de sesión exitoso";
    if (message != isValidData) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.SCALE,
        title: message,
        desc: "",
        autoHide: Duration(seconds: 3),
      )..show();
      setState(() {
        firstClick = false;
      });
    }
  }

  Widget _drawOptionCreateAccount() {
    return Container(
      margin: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.075,
        right: SizeConfig.screenWidth * 0.075,
      ),
      child: Row(
        children: [
          _drawDontYouHaveAnyAccountYet(),
          _drawButtonSignUp(),
        ],
      ),
    );
  }

  Text _drawDontYouHaveAnyAccountYet() {
    return Text(
      'No tienes cuenta?',
      style: TextStyle(
        color: ColorsApp.white,
        fontSize: getProportionateScreenWidth(SizeFonts.sizeText2),
        fontWeight: FontWeight.w300,
      ),
    );
  }

  TextButton _drawButtonSignUp() {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all<Color>(
          ColorsApp.blackOp35,
        ),
      ),
      child: Text(
        'Crear una cuenta',
        style: TextStyle(
          color: ColorsApp.blue,
          fontSize: getProportionateScreenWidth(SizeFonts.sizeText2),
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () {
        return Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpPage()));
      },
    );
  }

  Widget _drawContent() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.1,
          left: SizeConfig.screenWidth * 0.075,
          right: SizeConfig.screenWidth * 0.075,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                height: SizeConfig.screenHeight * 0.02,
              ),
            ),
            _drawTextWelcome(),
            SizedBox(height: 5.0),
            _drawDoYouHaveAaccount(),
            SizedBox(height: 45.0),
            _drawTitleLogin(),
            SizedBox(height: 25.0),
            _drawFieldEmail(loginBloc),
            SizedBox(height: 25.0),
            _drawFieldPassword(loginBloc),
            SizedBox(height: 45.0),
            _drawButtonLogin(loginBloc),
            SizedBox(height: SizeConfig.screenHeight * 0.12),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator(LoginBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.loading,
      builder: (context, snap) {
        return Container(
          child: Center(
            child: (snap.hasData && snap.data)
                ? CircularProgressIndicator()
                : null,
          ),
        );
      },
    );
  }

  Text _drawTextWelcome() {
    return Text(
      'Bienvenido!',
      style: TextStyle(
        color: ColorsApp.white,
        fontSize: getProportionateScreenWidth(SizeFonts.sizeTitle1),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _drawDoYouHaveAaccount() {
    return Text(
      'Tienes una cuenta?',
      style: TextStyle(
        color: ColorsApp.white,
        fontSize: getProportionateScreenWidth(SizeFonts.sizeText2),
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _drawTitleLogin() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Inicia Sesión",
        style: TextStyle(
          color: ColorsApp.white,
          fontSize: getProportionateScreenWidth(SizeFonts.sizeTitle2),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _drawFieldEmail(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            style:
                TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.person_outline, color: ColorsApp.white),
              labelStyle: TextStyle(
                color: ColorsApp.white,
              ),
              hintStyle: TextStyle(
                color: ColorsApp.white,
              ),
              labelText: 'Correo electrónico',
              errorStyle: TextStyle(fontWeight: FontWeight.w600),
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
      stream: bloc.password,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            style:
                TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                color: ColorsApp.white,
              ),
              hintStyle: TextStyle(
                color: ColorsApp.white,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.lock_outline, color: ColorsApp.white),
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña',
              errorStyle: TextStyle(fontWeight: FontWeight.w600),
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawButtonLogin(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return CustomRaisedButton(
          child: Text(
            'Iniciar sesión',
            style: TextStyle(
              color: ColorsApp.white,
              fontWeight: FontWeight.w600,
              fontSize: getProportionateScreenWidth(SizeFonts.sizeText2),
            ),
          ),
          color: ColorsApp.blue,
          disabledColor: ColorsApp.blackOp50,
          icon: SvgIconsApp.arrowRight,
          onPressed: !snapshot.hasData
              ? null
              : !firstClick
                  ? () async {
                      setState(() => firstClick = true);
                      String textMessage = await bloc.submit();
                      _showMessageAlert(textMessage);
                    }
                  : null,
        );
      },
    );
  }

  Widget _drawBackground() {
    return Container(
      color: ColorsApp.blackOp25,
      height: double.infinity,
      child: Opacity(
        opacity: 0.4,
        child: BackgroundsApp.back1,
      ),
    );
  }
}
