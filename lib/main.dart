import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/auth_bloc.dart';
import 'package:flutter_app_tenis/pages/home_page.dart';
import 'package:flutter_app_tenis/pages/login_page.dart';
import 'package:flutter_app_tenis/pages/signup_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    authBloc.restoreSession();

    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: _drawPage(),
      routes: {
        "home": (BuildContext context) => HomePage(),
        "login": (BuildContext context) => LoginPage(),
        "signup": (BuildContext context) => SignUpPage(),
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(174, 185, 127, 1.0),
      ),
    );
  }

  Widget _drawPage() {
    return StreamBuilder<bool>(
      stream: authBloc.isSessionValid,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData && snapshot.data) {
          return HomePage();
        }
        return LoginPage();
      },
    );
  }
}
