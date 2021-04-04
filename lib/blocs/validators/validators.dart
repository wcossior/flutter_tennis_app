import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Por favor ingrese un email válido');
    }
  });

  final validateName = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombre, sink) {
    Pattern pattern = r'[a-zA-Z]';
    RegExp regExp = new RegExp(pattern);

    if (nombre.length >= 3 && regExp.hasMatch(nombre)) {
      sink.add(nombre);
    } else {
      sink.addError('Nombre incorrecto');
    }
  });

  final validateCi =
      StreamTransformer<String, String>.fromHandlers(handleData: (ci, sink) {
    Pattern pattern = r'^[0-9]*$';
    RegExp regExp = new RegExp(pattern);

    if (ci.length >= 6 && regExp.hasMatch(ci)) {
      sink.add(ci);
    } else {
      sink.addError('Ci incorrecto');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Contraseña demasiado corta');
    }
  });
}
