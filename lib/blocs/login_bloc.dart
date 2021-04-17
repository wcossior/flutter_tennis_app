import 'package:flutter_app_tenis/blocs/auth_bloc.dart';
import 'package:flutter_app_tenis/repositories/auth_repository.dart';
import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class LoginBloc extends Validators {
  AuthRepository repository = AuthRepository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get password => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Observable.combineLatest2(email, password, (email, password) => true);
  Observable<bool> get loading => _loadingData.stream;

  Future<String> submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    return login(validEmail, validPassword);
  }

  Future<String> login(String email, String password) async {
    String resp = await repository.login(email, password);
    Map decodeData = json.decode(resp);
    if (decodeData.containsKey("msg")) {
      _loadingData.sink.add(false);
      String errorMessage = decodeData["msg"];
      return errorMessage;
    } else {
      _loadingData.sink.add(false);
      authBloc.openSession(decodeData);
      String successfulMessage = "Inicio de sesión exitoso";
      return successfulMessage;
    }
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
