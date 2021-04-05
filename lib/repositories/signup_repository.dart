import 'package:flutter_app_tenis/providers/signup_provider.dart';

class SignUpRepository {
   final SignUpProvider signUpProvider = SignUpProvider();

  Future<String> signUp(String ci, String email, String nombre, String password) =>
      signUpProvider.signUp(ci: ci,email: email, nombre: nombre, password: password);
}