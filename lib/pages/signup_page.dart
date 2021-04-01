import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/pages/login_page.dart';
import 'package:flutter_app_tenis/styles/backgrounds.dart';
import 'package:flutter_app_tenis/styles/colors.dart';
import 'package:flutter_app_tenis/styles/size_config.dart';
import 'package:flutter_app_tenis/styles/svgIcons.dart';
import 'package:flutter_app_tenis/widgets/customRaisedButton.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorsApp.blue),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Stack(
        children: [
          _drawBackground(),
          _drawFormLogin(),
        ],
      ),
      bottomNavigationBar: _drawButttonIhaveAccount(),
    );
  }

  Widget _drawBackground() {
    return Container(
      color: ColorsApp.blackOp25,
      height: double.infinity,
      child: Opacity(
        opacity: 0.4,
        child: BackgroundsApp.back2,
      ),
    );
  }

  Widget _drawFormLogin() {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
          top: SizeConfig.screenHeight * 0.05,
          left: SizeConfig.screenWidth * 0.075,
          right: SizeConfig.screenWidth * 0.075,
        ),
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: SizeConfig.screenHeight * 0.02,
              ),
            ),
            _drawTitleNewAccount(),
            SizedBox(height: 25.0),
            _drawFieldNombre(),
            SizedBox(height: 25.0),
            _drawFieldCi(),
            SizedBox(height: 25.0),
            _drawFieldEmail(),
            SizedBox(height: 25.0),
            _drawFieldPassword(),
            SizedBox(height: 45.0),
            _drawButtonNewAccount(),
            SizedBox(height: size.height * 0.05),
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
        style: TextStyle(
          color: ColorsApp.white,
          fontSize: getProportionateScreenWidth(SizeFonts.sizeTitle2),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _drawButttonIhaveAccount() {
    return Container(
      margin: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.075,
        right: SizeConfig.screenWidth * 0.075,
      ),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
            ColorsApp.blackOp35,
          ),
        ),
        child: Text(
          'Ya tengo una cuenta',
          style: TextStyle(
            color: ColorsApp.blue,
            fontSize: getProportionateScreenWidth(SizeFonts.sizeText2),
            fontWeight: FontWeight.w600,
          ),
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
      child: TextField(
        style: TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.emailAddress,
        // onChanged: bloc.changeEmail,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.mail_outline, color: ColorsApp.white),
          labelStyle: TextStyle(
            color: ColorsApp.white,
          ),
          hintStyle: TextStyle(
            color: ColorsApp.white,
          ),
          labelText: 'Correo electrónico',
          errorStyle: TextStyle(fontWeight: FontWeight.w600),
          hintText: 'Ingresa tu correo electrónico',
          // errorText: snapshot.error,
        ),
      ),
    );
  }

  Widget _drawFieldCi() {
    return Container(
      child: TextField(
        style: TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.emailAddress,
        // onChanged: bloc.changeEmail,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_pin, color: ColorsApp.white),
          labelStyle: TextStyle(
            color: ColorsApp.white,
          ),
          hintStyle: TextStyle(
            color: ColorsApp.white,
          ),
          labelText: 'Ci',
          errorStyle: TextStyle(fontWeight: FontWeight.w600),
          hintText: 'Ingresa el numero de tu ci',
          // errorText: snapshot.error,
        ),
      ),
    );
  }

  Widget _drawFieldNombre() {
    return Container(
      child: TextField(
        style: TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
        keyboardType: TextInputType.emailAddress,
        // onChanged: bloc.changeEmail,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_outline, color: ColorsApp.white),
          labelStyle: TextStyle(
            color: ColorsApp.white,
          ),
          hintStyle: TextStyle(
            color: ColorsApp.white,
          ),
          labelText: 'Nombre',
          errorStyle: TextStyle(fontWeight: FontWeight.w600),
          hintText: 'Ingresa tu nombre',
          // errorText: snapshot.error,
        ),
      ),
    );
  }

  Widget _drawFieldPassword() {
    return Container(
      child: TextField(
        style: TextStyle(color: ColorsApp.white, fontWeight: FontWeight.w600),
        obscureText: true,
        // onChanged: bloc.changePassword,
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
          // errorText: snapshot.error,
        ),
      ),
    );
  }

  Widget _drawButtonNewAccount() {
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
      // onPressed: !snapshot.hasData
      //     ? null
      //     : !firstClick
      //         ? () {
      //             setState(() => firstClick = true);
      //             bloc.submit();
      //           }
      //         : null,
      onPressed: () {},
    );
  }
}
