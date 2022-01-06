import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotify/Domain/Logic/Autenticate/AbstratAutenticate.dart';

class AuntenticateBloc with ChangeNotifier {
  final AbstractAutenticate abstractAutenticate;
  User? get user => FirebaseAuth.instance.currentUser;

  AuntenticateBloc(this.abstractAutenticate);

  Future googleSign() async {
    final resp = await abstractAutenticate.googleSign();
    return resp;
  }

  void singOut() async {
    await abstractAutenticate.singOut();
  }

  Future facebookSign() async {
    final resp = await abstractAutenticate.facebookSign();
    return resp;
  }

  Future emailAndPassSign(
      {required String email, required String password}) async {
    final resp = await abstractAutenticate.emailAndPassSign(
        email: email, pass: password);
    return resp;
  }

  Future emailAndPassSignUp(
      {required String email, required String password}) async {
    final resp = await abstractAutenticate.emailAndPassSignUp(
        email: email, pass: password);
    return resp;
  }
}
