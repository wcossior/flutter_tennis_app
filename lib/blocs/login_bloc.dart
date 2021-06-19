import 'package:flutter_app_tenis/blocs/auth_bloc.dart';
import 'package:flutter_app_tenis/repositories/auth_repository.dart';
import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class LoginBloc extends Validators {
  AuthRepository repository = AuthRepository();

  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingContoller = PublishSubject<bool>();

  Function(String) get sinkEmail => _emailController.sink.add;
  Function(String) get sinkPassword => _passwordController.sink.add;

  Stream<String> get streamEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get streamPassword => _passwordController.stream.transform(validatePassword);
  Stream<bool> get streamSubmitValid =>
      Observable.combineLatest2(streamEmail, streamPassword, (email, password) => true);
  Observable<bool> get streamLoading => _loadingContoller.stream;

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loadingContoller.close();
  }

  Future<String> submit(String dispositivo) {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    _loadingContoller.sink.add(true);
    return login(validEmail, validPassword, dispositivo);
  }

  Future<String> login(String email, String password, String dispositivo) async {
    String resp = await repository.login(email, password, dispositivo);
    Map decodeData = json.decode(resp);
    _loadingContoller.sink.add(false);
    if (decodeData.containsKey("msg")) {
      String errorMessage = decodeData["msg"];
      return errorMessage;
    } else {
      authBloc.openSession(decodeData);
      String successfulMessage = "Inicio exitoso";
      return successfulMessage;
    }
  }
}
