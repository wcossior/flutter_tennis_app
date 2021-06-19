import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  String _url = "tennisapi.herokuapp.com";

  Future<String> login({
    @required String email,
    @required String password,
    @required String dispositivo,
  }) async {
    final authData = {"email": email, "password": password, "dispositivo": dispositivo};
    final url = Uri.https(_url, "/login");

    final resp = await http.post(url, body: authData);
    return resp.body;
  }
}
