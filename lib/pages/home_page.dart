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
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    print(prefs.user["nombre"]);

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: bloc.logoutUser,
          child: Text(
            "Logout",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
