import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<String> signUp(
      {@required String ci,
      @required String nombre,
      @required String email,
      @required String password,
      @required String tokenDispositivo}) async {
    final signUpData = {
      "ci": ci,
      "nombre": nombre,
      "email": email,
      "password": password,
      "dispositivo": tokenDispositivo,
    };
    final url = Uri.https(_url, "/newUser");

    final resp = await http.post(url, body: signUpData);

    return resp.body;
  }
}
