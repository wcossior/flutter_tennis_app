import 'package:flutter_app_tenis/providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider authProvider = AuthProvider();

  Future<String> login(String email, String password) =>
      authProvider.login(email: email, password: password);
}
