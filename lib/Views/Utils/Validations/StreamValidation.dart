// ignore_for_file: file_names

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:spotify/Views/Utils/Validations/Validation.dart';

class LoginValidate with Validators {
  final _emailcontroller = BehaviorSubject<String>();
  final _passwordcontroller = BehaviorSubject<String>();

//   // Recuperar los datos del Stream
  Stream<String> get emailStrem =>
      _emailcontroller.stream.transform(validarEmail);
  Stream<String> get passStrem =>
      _passwordcontroller.stream.transform(validarpassword);
  Stream<bool> get formValidStream => Rx.combineLatest2(
      emailStrem,
      passStrem,
      (
        dynamic e,
        dynamic p,
      ) =>
          true);

//   // Insertar valores al Stream
  Function(String) get changeemail => _emailcontroller.sink.add;
  Function(String) get changepass => _passwordcontroller.sink.add;

//   // Obtener el último valor ingresado a los streams
// con validacion de si es nulo o no
  String? get date => _emailcontroller.value;
  String? get city => _passwordcontroller.value;

//Liberacion de flujos
  dispose() {
    _emailcontroller.close();
    _passwordcontroller.close();
  }
}
