import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/login_bloc.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';
import 'package:flutter_app_tenis/styles/styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // _drawBackground(size),
          _drawContent(context),
          // _loadingIndicator(loginBloc),
        ],
      ),
      bottomNavigationBar: _drawOptionCreateAccount(size),
    );
  }

  Widget _drawOptionCreateAccount(Size size) {
    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.075,
        right: size.width * 0.075,
      ),
      child: Row(
        children: [
          _drawDontYouHaveAnyAccountYet(),
          _drawButtonSignUp(),
        ],
      ),
    );
  }

  Widget _drawContent(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: size.height * 0.1,
          left: size.width * 0.075,
          right: size.width * 0.075,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Container(
                height: size.height * 0.02,
              ),
            ),
            _drawTextWelcome(),
            SizedBox(height: 5.0),
            _drawDoYouHaveAaccount(),
            SizedBox(height: 30.0),
            _drawTitleLogin(),
            _drawFieldEmail(loginBloc),
            _drawFieldPassword(loginBloc),
            _drawButtonLogin(loginBloc),
            SizedBox(height: size.height * 0.12),
          ],
        ),
      ),
    );
  }

  Widget _drawTitleLogin() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 30.0),
      child: Text(
        "Inicia Sesión",
        style: AppText.blackBoldMonserrat_24,
      ),
    );
  }

  TextButton _drawButtonSignUp() {
    return TextButton(
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
    );
  }

  Text _drawDontYouHaveAnyAccountYet() {
    return Text(
      'No tienes cuenta?',
      style: AppText.blackLightOpenSans_16,
    );
  }

  Text _drawDoYouHaveAaccount() {
    return Text(
      'Tienes una cuenta?',
      style: AppText.blackLightOpenSans_16,
    );
  }

  Text _drawTextWelcome() {
    return Text(
      'Bienvenido!',
      style: AppText.blackBoldMonserrat_35,
    );
  }

  Widget _loadingIndicator(LoginBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.loading,
      builder: (context, snap) {
        return Container(
          child: Center(
            child:
                (snap.hasData && snap.data) ? CircularProgressIndicator() : null,
          ),
        );
      },
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
              filled: true,
              fillColor: AppColors.greyOp75,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              enabledBorder: AppTextFields.border,
              focusedBorder: AppTextFields.border,
              errorBorder: AppTextFields.border,
              focusedErrorBorder: AppTextFields.border,
              prefixIcon: Icon(Icons.person_outline, color: AppColors.blue),
              labelStyle: AppText.blackNormalOpenSans_16,
              errorStyle: AppText.redNormalOpenSans_12,
              labelText: 'Correo electrónico',
              hintText: 'Correo electrónico',
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
            style: AppText.blackNormalOpenSans_16,
            obscureText: true,
            onChanged: bloc.changePassword,
            decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.greyOp75,
                enabledBorder: AppTextFields.border,
                focusedBorder: AppTextFields.border,
                errorBorder: AppTextFields.border,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedErrorBorder: AppTextFields.border,
                prefixIcon: Icon(Icons.lock_outline, color: AppColors.blue),
                labelText: 'Contraseña',
                hintText: 'Contraseña',
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
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: FlatButton(
            child: Text(
              'Iniciar sesión',
              style: AppText.whiteSemiBoldOpenSans_16,
            ),
            color: AppColors.blueOp50,
            disabledColor: AppColors.blackOp50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
            onPressed: !snapshot.hasData ? null : bloc.submit,
          ),
        );
      },
    );
  }

  Widget _drawBackground(Size size) {
    // return Center(child: drawIconPlayers(size));
  }
}
