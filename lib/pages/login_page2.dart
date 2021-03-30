import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/login_bloc.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';
import 'package:flutter_app_tenis/styles/styles.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColors.blue),
        elevation: 0.0,
        backgroundColor: AppColors.white,
      ),
      body: _drawFormLogin(),
    );
  }

  Widget _drawFormLogin() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: size.width * 0.85,
        margin: EdgeInsets.only(left: size.width * 0.075),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: size.height * 0.2,
              ),
            ),
            _drawTitleLogin(),
            Column(
              children: <Widget>[
                _drawFieldEmail(loginBloc),
                _drawFieldPassword(loginBloc),
                _drawButtonLogin(loginBloc),
                _loadingIndicator(loginBloc)
              ],
            ),
            _drawButttonNewAccount(),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }

  Widget _drawTitleLogin() {
    return Container(
      margin: EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Iniciar Sesión",
        style: AppText.blackBoldMonserrat_24,
      ),
    );
  }

  Widget _loadingIndicator(LoginBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.loading,
      builder: (context, snap) {
        return Container(
          child:
              (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
        );
      },
    );
  }

  Widget _drawButttonNewAccount() {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            AppColors.blackOp35,
          ),
        ),
        child: Text(
          'Crear una cuenta',
          style: AppText.blueSemiBoldOpenSans_16,
        ),
        onPressed: () {
          return Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignUpPage()));
        },
      ),
    );
  }

  Widget _drawFieldEmail(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.email,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.only(bottom: 15.0),
          child: TextField(
            style: AppText.blackNormalOpenSans_16,
            keyboardType: TextInputType.emailAddress,
            onChanged: bloc.changeEmail,
            decoration: InputDecoration(
              enabledBorder: AppTextFields.border,
              focusedBorder: AppTextFields.border,
              icon: Icon(Icons.person_outline, color: AppColors.blackOp100),
              labelStyle: AppText.blackNormalOpenSans_16,
              errorStyle: AppText.redNormalOpenSans_12,
              labelText: 'Correo electrónico o nombre',
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
          margin: EdgeInsets.only(bottom: 15.0),
          child: TextField(
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                enabledBorder: AppTextFields.border,
                focusedBorder: AppTextFields.border,
                icon: Icon(Icons.lock_outline, color: AppColors.blackOp100),
                labelText: 'Contraseña',
                labelStyle: AppText.blackNormalOpenSans_16,
                errorStyle: AppText.redNormalOpenSans_12,
                errorText: snapshot.error),
          ),
        );
      },
    );
  }

  Widget _drawButtonLogin(LoginBloc bloc) {
    return StreamBuilder<Object>(
      stream: bloc.submitValid,
      builder: (context, snapshot) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: FlatButton(
            child: Text(
              'Ingresar',
              style: AppText.whiteSemiBoldOpenSans_16,
            ),
            color: AppColors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            textColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            onPressed: !snapshot.hasData ? null : bloc.submit,
          ),
        );
      },
    );
  }
}
