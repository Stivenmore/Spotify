// ignore_for_file: file_names
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';
import 'package:spotify/Views/Utils/Validations/StreamValidation.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final RoundedLoadingButtonController controller =
      RoundedLoadingButtonController();
  bool obstru = false;
  bool isloading = false;
  final validate = LoginValidate();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuntenticateBloc>(context);
    Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Container(
          height: responsive.height,
          width: responsive.width,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    child: isloading == true
                        ? const LinearProgressIndicator(
                            color: Colors.purple,
                            backgroundColor: Colors.white,
                          )
                        : Container(
                            height: 0,
                          ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  const Text(
                    'Hola!',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Registrate para acceder a nuestros servicios',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Vive a tu ritmo, vive a tu musica.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                                  hintText: 'Escribe tu correo',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorStyle: TextStyle(color: Colors.red),
                                  errorText: snapshot.error as String?),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                                          ? const Icon(
                                              Icons.visibility_off_rounded,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.grey,
                                            )),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16)),
                                  hintText: 'Escribe tu contraseña',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  errorStyle:
                                      const TextStyle(color: Colors.red),
                                  errorMaxLines: 2,
                                  errorText: snapshot.error as String?),
                            );
                          }),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: responsive.wp(80),
                    child: StreamBuilder(
                        stream: validate.formValidStream,
                        builder: (context, snapshot) {
                          return RoundedLoadingButton(
                            height: 60,
                            borderRadius: 12,
                            controller: controller,
                            color: const Color(0xff3F3959),
                            successColor: const Color(0xffFAB770),
                            onPressed: () async {
                              if (snapshot.hasData) {
                                final resp = await provider.emailAndPassSignUp(
                                    email: controller1.text,
                                    password: controller2.text);
                                if (resp['success']) {
                                  Timer(const Duration(milliseconds: 700), () {
                                    controller.success();
                                  });
                                  Timer(const Duration(milliseconds: 1200), () {
                                    controller.reset();
                                  });
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, '/home', (route) => false);
                                } else {
                                  Timer(const Duration(milliseconds: 700), () {
                                    controller.error();
                                    if (resp["message"] != "") {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(resp["message"])));
                                    }
                                  });
                                  Timer(const Duration(milliseconds: 1900), () {
                                    controller.reset();
                                  });
                                }
                              } else {
                                Timer(const Duration(milliseconds: 700), () {
                                  controller.error();
                                });
                                Timer(const Duration(milliseconds: 1900), () {
                                  controller.reset();
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              height: 60,
                              child: const Center(
                                child: Text(
                                  'Registrar',
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
                ]),
              ))),
    );
  }
}
