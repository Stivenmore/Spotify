// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Provider/AutenticateProvider.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    validate(context);
    super.initState();
  }

  validate(BuildContext context) async {
    Future.delayed(const Duration(seconds: 5), () {
      AutenticateProvider provider =
          Provider.of<AutenticateProvider>(context, listen: false);
      if (provider.user != null) {
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AutenticateProvider provider =
        Provider.of<AutenticateProvider>(context, listen: false);
    Responsive responsive = Responsive(context);
    return Scaffold(
      backgroundColor: const Color(0xff313249),
      body: Container(
          height: responsive.height,
          width: responsive.width,
          child: Stack(
            children: [
              Positioned(
                  top: 0,
                  bottom: 0,
                  child: Opacity(
                    opacity: 0.46,
                    child: Container(
                      height: responsive.hp(100),
                      width: responsive.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            tileMode: TileMode.mirror,
                            stops: [0.03, 0.1, 0.18, 0.4],
                            colors: [
                              Color(0xff7D738E),
                              Color(0xff53486F),
                              Color(0xff313249),
                              Color(0xff322550),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                      ),
                    ),
                  )),
              Positioned(
                bottom: 0,
                child: Container(
                  height: responsive.hp(80),
                  width: responsive.width,
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                          radius: 0.7,
                          focalRadius: 0.5,
                          colors: [Color(0xff60307A), Color(0xff313249)])),
                  child: Padding(
                    padding: EdgeInsets.only(top: responsive.hp(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 20),
                            child: Text(
                              'SPOTIFY',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            )),
                        const CircularProgressIndicator(
                          backgroundColor: Colors.purple,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
