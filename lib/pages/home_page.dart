import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_tenis/blocs/home_bloc.dart';
import 'package:flutter_app_tenis/preferences/userPreferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc = HomeBloc();
  bool showMessage = false;
  final prefs = new UserPreferences();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => showMessageLoginSuccessful());
  }

  @override
  Widget build(BuildContext context) {
    print(prefs.user["nombre"]);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton(
              onPressed: bloc.logoutUser,
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  void showMessageLoginSuccessful() {
    if (prefs.wasShownMessage == null) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.SCALE,
        title: "Inicio de sesión exitoso",
        desc: "",
        autoHide: Duration(seconds: 3),
      )..show();
      prefs.wasShownMessage = true;
    }
  }
}
