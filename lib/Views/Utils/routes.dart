import 'package:flutter/material.dart';
import 'package:spotify/Views/Autentication/Login.dart';
import 'package:spotify/Views/Autentication/Register.dart';
import 'package:spotify/Views/Home/Home.dart';
import 'package:spotify/Views/Loadins/Splash.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (BuildContext context) => const Splash(),
  '/home': (BuildContext context) => Home(),
  '/login': (BuildContext context) => const Login(),
  '/register': (BuildContext context) => const Register()
};
