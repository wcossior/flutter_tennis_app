import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/signup_bloc.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/utils/keyboard.dart';
import 'package:flutter_app_tenis/widgets/customButton.dart';
import 'package:flutter_app_tenis/widgets/customSurfixIcon.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpBloc signUpBloc = SignUpBloc();
  bool firstClick = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.center,
          children: [
            _drawContent(),
            _loadingIndicator(signUpBloc),
          ],
        ),
        bottomNavigationBar: _drawOptionBackToLogin(),
      ),
    );
  }

  Widget _drawOptionBackToLogin() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenHeight(15.0),
      ),
      width: SizeConfig.screenWidth * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _drawTextIhaveAccount(),
          SizedBox(width: 10.0),
          _drawButttonIhaveAccount(),
        ],
      ),
    );
  }

  Text _drawTextIhaveAccount() {
    return Text(
      '¿Ya tienes cuenta?',
      style: Theme.of(context).textTheme.bodyText2,
    );
  }

  Widget _drawButttonIhaveAccount() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Text(
        "Iniciar sesión",
        style: Theme.of(context).textTheme.bodyText2.copyWith(color: ColorsApp.orange),
      ),
    );
  }

  Widget _loadingIndicator(SignUpBloc bloc) {
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
            _drawTitleNewAccount(),
            SizedBox(height: 25.0),
            _drawFieldNombre(signUpBloc),
            SizedBox(height: 25.0),
            _drawFieldCi(signUpBloc),
            SizedBox(height: 25.0),
            _drawFieldEmail(signUpBloc),
            SizedBox(height: 25.0),
            _drawFieldPassword(signUpBloc),
            SizedBox(height: 45.0),
            _drawButtonSignUp(signUpBloc),
            SizedBox(height: getProportionateScreenHeight(20.0)),
          ],
        ),
      ),
    );
  }

  Widget _drawTitleNewAccount() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Nueva cuenta",
        style: Theme.of(context).textTheme.headline1.copyWith(color: ColorsApp.green),
      ),
    );
  }

  Widget _drawFieldEmail(SignUpBloc bloc) {
    return StreamBuilder(
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

  Widget _drawFieldCi(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.streamCi,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.number,
            onChanged: bloc.sinkCi,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/IdCard.svg"),
              labelText: 'Ci',
              hintText: 'Ingresa el numero de tu ci',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawFieldNombre(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.streamNombre,
      builder: (context, snapshot) {
        return Container(
          child: TextField(
            keyboardType: TextInputType.name,
            onChanged: bloc.sinkNombre,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
              labelText: 'Nombre',
              hintText: 'Ingresa tu nombre',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );
  }

  Widget _drawFieldPassword(SignUpBloc bloc) {
    return StreamBuilder(
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

  Widget _drawButtonSignUp(SignUpBloc bloc) {
    return StreamBuilder(
      stream: bloc.streamSubmitValid,
      builder: (context, snapshot) {
        return CustomButton(
          child: Text(
            'Registrarse',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: !snapshot.hasData
              ? null
              : !firstClick
                  ? () async {
                      setState(() => firstClick = true);
                      KeyboardUtil.hideKeyboard(context);
                      String textMessage = await bloc.submit();
                      if (textMessage == "Cuenta creada exitosamente!") {
                        var message = showMessageSignUpSuccessful();
                        await message.show();
                        return Navigator.pop(context);
                      }
                      _showMessageAlert(textMessage);
                    }
                  : null,
        );
      },
    );
  }

  void _showMessageAlert(String message) {
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

  AwesomeDialog showMessageSignUpSuccessful() {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.SCALE,
      title: "Registro existoso",
      desc: "Ya puede iniciar sesión",
      autoHide: Duration(seconds: 4),
    );
  }
}
