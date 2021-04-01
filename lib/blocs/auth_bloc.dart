import 'package:flutter_app_tenis/preferences/userPreferences.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class AuthBloc {
  String _tokenString;
  final prefs = new UserPreferences();
  final PublishSubject _isSessionValid =
      PublishSubject<bool>(); //streamController
  Observable<bool> get isSessionValid => _isSessionValid.stream; //strean

  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
    _tokenString = await prefs.token;
    if (_tokenString != null && _tokenString.length > 0) {
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }

  void openSession(Map resp) {
    String token = resp["tokenReturn"];
    String user = json.encode(resp["user"]).toString();
    prefs.token = token;
    prefs.user = user;
    _tokenString = token;
    _isSessionValid.sink.add(true);
  }

  void closeSession() async {
    prefs.logout();
    _isSessionValid.sink.add(false);
  }
}

final authBloc = AuthBloc();
