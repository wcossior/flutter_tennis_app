import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/pages/login_page.dart';
import 'package:flutter_app_tenis/styles/styles.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                height: size.height * 0.10,
              ),
            ),
            _drawTitleLogin(),
            Column(
              children: <Widget>[
                _drawFieldNombre(),
                _drawFieldCi(),
                _drawFieldEmail(),
                _drawFieldPassword(),
                _drawButtonNewAccount(),
              ],
            ),
            _drawButttonIhaveAccount(),
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
        "Nueva Cuenta",
        style: AppText.blackBoldMonserrat_24,
      ),
    );
  }

  Widget _drawButttonIhaveAccount() {
    return Container(
      alignment: Alignment.centerLeft,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            AppColors.blackOp35,
          ),
        ),
        child: Text(
          'Ya tengo una cuenta',
          style: AppText.blueSemiBoldOpenSans_16,
        ),
        onPressed: () {
          return Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    );
  }

  Widget _drawFieldEmail() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        style: AppText.blackNormalOpenSans_16,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          enabledBorder: AppTextFields.border,
          focusedBorder: AppTextFields.border,
          icon: Icon(Icons.mail_outline, color: AppColors.blackOp100),
          labelStyle: AppText.blackNormalOpenSans_16,
          errorStyle: AppText.redNormalOpenSans_12,
          labelText: 'Correo electrónico',
        ),
      ),
    );
  }

  Widget _drawFieldCi() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        style: AppText.blackNormalOpenSans_16,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          enabledBorder: AppTextFields.border,
          focusedBorder: AppTextFields.border,
          icon: Icon(Icons.person_pin, color: AppColors.blackOp100),
          labelStyle: AppText.blackNormalOpenSans_16,
          errorStyle: AppText.redNormalOpenSans_12,
          labelText: 'Ci',
        ),
      ),
    );
  }

  Widget _drawFieldNombre() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        style: AppText.blackNormalOpenSans_16,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          enabledBorder: AppTextFields.border,
          focusedBorder: AppTextFields.border,
          icon: Icon(Icons.person_outline, color: AppColors.blackOp100),
          labelStyle: AppText.blackNormalOpenSans_16,
          errorStyle: AppText.redNormalOpenSans_12,
          labelText: 'Nombre Completo',
        ),
      ),
    );
  }

  Widget _drawFieldPassword() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: AppTextFields.border,
          focusedBorder: AppTextFields.border,
          icon: Icon(Icons.lock_outline, color: AppColors.blackOp100),
          labelText: 'Contraseña',
          labelStyle: AppText.blackNormalOpenSans_16,
          errorStyle: AppText.redNormalOpenSans_12,
        ),
      ),
    );
  }

  Widget _drawButtonNewAccount() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15.0),
      child: FlatButton(
        child: Text(
          'Registrarse',
          style: AppText.whiteSemiBoldOpenSans_16,
        ),
        color: AppColors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        onPressed: () {},
      ),
    );
  }
}
