// ignore_for_file: file_names

import 'dart:async';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{1,}))$';
    RegExp regExp = RegExp(pattern as String);

    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Correo inválido');
    }
  });

  final validarpassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    Pattern pattern = r"^[0-9]{6,12}$";
    RegExp regExp = RegExp(pattern as String);

    if (regExp.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError(
          'Ingrese una contraseña válido con longitud entre 6 y 12 numeros');
    }
  });
}
