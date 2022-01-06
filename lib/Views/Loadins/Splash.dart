// ignore_for_file: file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Views/General/General.dart';
import 'package:spotify/Views/Home/Home.dart';
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
    final spotifybloc = Provider.of<SpotifyProvider>(context, listen: false);
    await spotifybloc.getCategoria();
    spotifybloc.clearerror();
    Future.delayed(const Duration(seconds: 5), () {
      AuntenticateBloc provider =
          Provider.of<AuntenticateBloc>(context, listen: false);
      if (provider.user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const General()),
            (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuntenticateBloc provider =
        Provider.of<AuntenticateBloc>(context, listen: false);
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
