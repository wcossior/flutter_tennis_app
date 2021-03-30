import 'package:flutter_app_tenis/blocs/auth_bloc.dart';

class HomeBloc {
  logoutUser() {
    authBloc.closeSession();
  }
}
