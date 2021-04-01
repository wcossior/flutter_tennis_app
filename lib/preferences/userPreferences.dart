import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get token {
    var token = _prefs.get("token");
    return token;
  }

  get user {
    var user = _prefs.get("user");
    Map decodedUser = json.decode(user);
    return decodedUser;
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  set user(String user) {
    _prefs.setString('user', user);
  }

  logout() {
    _prefs.remove("token");
    _prefs.remove("user");
  }

  isLogged() {
    return _prefs.containsKey("token");
  }
}
