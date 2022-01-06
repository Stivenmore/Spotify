// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Views/General/General.dart';
import 'package:spotify/Views/Home/Home.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';
import 'package:spotify/Views/Utils/Validations/StreamValidation.dart';

class Login extends StatefulWidget {
  final String? message;
  const Login({Key? key, this.message}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  final _prefs = UserPreferences();
  bool obstru = false;
  bool isloading = false;
  final validate = LoginValidate();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  void initState() {
    if (widget.message != null && widget.message != '') {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: Text('Error ${widget.message}'),
        actions: [],
      ));
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final autenticatebloc = Provider.of<AuntenticateBloc>(context);
    final spotifybloc = Provider.of<SpotifyProvider>(context);
    Responsive responsive = Responsive(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[100],
          elevation: 0,
        ),
        backgroundColor: Colors.grey[100],
        body: Container(
          height: responsive.height,
          width: responsive.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: isloading == true
                        ? LinearProgressIndicator(
                            color: Colors.purple,
                            backgroundColor: Colors.white,
                          )
                        : Container(
                            height: 0,
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _prefs.locale == 'CO' ? ' Hola!' : ' Hello!',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 58,
                        fontWeight: FontWeight.w800),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: StreamBuilder(
                          stream: validate.emailStrem,
                          builder: (context, snapshot) {
                            return TextFormField(
                              cursorColor: Colors.grey,
                              controller: controller1,
                              onChanged: (value) {
                                validate.changeemail(value);
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  hintText: _prefs.locale == 'CO'
                                      ? 'Escribe tu correo'
                                      : 'Email',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorStyle: TextStyle(color: Colors.red),
                                  errorText: snapshot.error as String?),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: StreamBuilder(
                          stream: validate.passStrem,
                          builder: (context, snapshot) {
                            return TextFormField(
                              keyboardType: TextInputType.number,
                              controller: controller2,
                              cursorColor: Colors.grey,
                              obscureText: obstru,
                              onChanged: (value) {
                                validate.changepass(value);
                              },
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obstru = !obstru;
                                        });
                                      },
                                      icon: obstru == true
                                          ? Icon(
                                              Icons.visibility_off_rounded,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.grey,
                                            )),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  hintText: _prefs.locale == 'CO'
                                      ? 'Escribe tu contraseña'
                                      : 'Password',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorStyle: TextStyle(color: Colors.red),
                                  errorMaxLines: 2,
                                  errorText: snapshot.error as String?),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SizedBox(
                      width: responsive.wp(80),
                      child: StreamBuilder(
                          stream: validate.formValidStream,
                          builder: (context, snapshot) {
                            return RoundedLoadingButton(
                              height: 60,
                              borderRadius: 12,
                              controller: controller,
                              color: Color(0xff3F3959),
                              successColor: Color(0xffFAB770),
                              onPressed: () async {
                                if (snapshot.hasData) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  final resp =
                                      await autenticatebloc.emailAndPassSign(
                                          email: controller1.text,
                                          password: controller2.text);
                                  final resp2 =
                                      await spotifybloc.getCategoria();
                                  setState(() {
                                    isloading = false;
                                  });
                                  if (resp['success']) {
                                    Timer(Duration(milliseconds: 700), () {
                                      controller.success();
                                    });
                                    Timer(Duration(milliseconds: 1200), () {
                                      controller.reset();
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => General()),
                                        (route) => false);
                                  } else {
                                    Timer(Duration(milliseconds: 700), () {
                                      controller.error();
                                      if (resp["message"] != "") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content:
                                                    Text(resp["message"])));
                                      }
                                    });
                                    Timer(Duration(milliseconds: 1900), () {
                                      controller.reset();
                                    });
                                  }
                                } else {
                                  Timer(Duration(milliseconds: 700), () {
                                    controller.error();
                                  });
                                  Timer(Duration(milliseconds: 1900), () {
                                    controller.reset();
                                  });
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                height: 60,
                                child: Center(
                                  child: Text(
                                    _prefs.locale == 'CO'
                                        ? 'Iniciar Sesion'
                                        : 'Sign In',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    _prefs.locale == 'CO'
                        ? '------ O continua con ------'
                        : '------ Or continue with ------',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  IgnorePointer(
                    ignoring: isloading,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isloading = true;
                            });
                            final resp = await autenticatebloc.googleSign();
                            final resp2 = await spotifybloc.getCategoria();
                            setState(() {
                              isloading = false;
                            });
                            if (resp["success"] && resp2 == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => General()),
                                  (route) => false);
                            } else {
                              if (resp["message"] != "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resp["message"])));
                              }
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(16)),
                            child: FadeInImage(
                                height: 60,
                                width: 60,
                                placeholder: AssetImage('assets/no-image.jpg'),
                                image: AssetImage('assets/google.png')),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isloading = true;
                            });
                            final resp = await autenticatebloc.facebookSign();
                            final resp2 = await spotifybloc.getCategoria();
                            setState(() {
                              isloading = false;
                            });
                            if (resp["success"] && resp2 == true) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => General()),
                                  (route) => false);
                            } else {
                              if (resp["message"] != "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(resp["message"])));
                              }
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.circular(16)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: FadeInImage(
                                  placeholder:
                                      AssetImage('assets/no-image.jpg'),
                                  image: AssetImage('assets/facebook.png')),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿No tienes una cuenta?, '),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Registrate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
