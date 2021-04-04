import 'package:flutter_app_tenis/blocs/repositories/signup_repository.dart';
import 'package:flutter_app_tenis/blocs/validators/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:convert';

class SignUpBloc extends Validators {
  SignUpRepository repository = SignUpRepository();

  final BehaviorSubject _ciController = BehaviorSubject<String>();
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _nombreController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeCi => _ciController.sink.add;
  Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get ci => _ciController.stream.transform(validateCi);
  Stream<String> get nombre => _nombreController.stream.transform(validateName);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValid => Observable.combineLatest4(
      email, password, ci, nombre, (email, password, ci, nombre) => true);
  Observable<bool> get loading => _loadingData.stream;

  Future<String> submit() {
    final validEmail = _emailController.value;
    final validCi = _ciController.value;
    final validNombre = _nombreController.value;
    final validPassword = _passwordController.value;
    _loadingData.sink.add(true);
    return signUp(validCi, validEmail, validNombre, validPassword);
  }

  Future<String> signUp(
      String ci, String email, String nombre, String password) async {
    String resp = await repository.signUp(ci, email, nombre, password);
    Map decodeData = json.decode(resp);
    if (decodeData["msg"] == "Ocurrio un error") {
      _loadingData.sink.add(false);
      String errorMessage = decodeData["msg"];
      return errorMessage;
    } else {
      _loadingData.sink.add(false);
      String successfulMessage = decodeData["msg"];
      return successfulMessage;
    }
  }

  void dispose() {
    _emailController.close();
    _ciController.close();
    _nombreController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
