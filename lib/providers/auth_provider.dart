import 'package:flutter/material.dart';

class AuthProvider {
  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return "token-info";
  }
}
