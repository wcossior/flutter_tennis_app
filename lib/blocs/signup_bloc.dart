import 'package:flutter_app_tenis/repositories/signup_repository.dart';
import 'package:flutter_app_tenis/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class SignUpBloc extends Validators {
  SignUpRepository repository = SignUpRepository();

  final BehaviorSubject _ciController = BehaviorSubject<String>();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _nombreController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingController = PublishSubject<bool>();

  Function(String) get sinkEmail => _emailController.sink.add;
  Function(String) get sinkCi => _ciController.sink.add;
  Function(String) get sinkNombre => _nombreController.sink.add;
  Function(String) get sinkPassword => _passwordController.sink.add;

  Stream<String> get streamEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get streamCi => _ciController.stream.transform(validateCi);
  Stream<String> get streamNombre => _nombreController.stream.transform(validateName);
  Stream<String> get streamPassword => _passwordController.stream.transform(validatePassword);
  Stream<bool> get streamSubmitValid => Observable.combineLatest4(
      streamEmail, streamPassword, streamCi, streamNombre, (email, password, ci, nombre) => true);
  Observable<bool> get streamLoading => _loadingController.stream;

  void dispose() {
    _emailController.close();
    _ciController.close();
    _nombreController.close();
    _passwordController.close();
    _loadingController.close();
  }

  Future<String> submit(String tokenDispositivo) {
    final validEmail = _emailController.value;
    final validCi = _ciController.value;
    final validNombre = _nombreController.value;
    final validPassword = _passwordController.value;
    _loadingController.sink.add(true);
    return signUp(validCi, validEmail, validNombre, validPassword, tokenDispositivo);
  }

  Future<String> signUp(String ci, String email, String nombre, String password, String tokenDispositivo) async {
    String resp = await repository.signUp(ci, email, nombre, password, tokenDispositivo);
    Map decodeData = json.decode(resp);
    if (decodeData["msg"] == "Ocurrio un error") {
      _loadingController.sink.add(false);
      String errorMessage = decodeData["msg"];
      return errorMessage;
    } else {
      _loadingController.sink.add(false);
      String successfulMessage = decodeData["msg"];
      return successfulMessage;
    }
  }
}
