import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Bloc/AutenticateBloc.dart';
import 'package:spotify/Domain/Bloc/SpotifyBloc.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Views/Home/Home.dart';
import 'package:spotify/Views/Home/InfoPerson.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerClass.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerHedden.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerItems.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);

  @override
  State<General> createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  final _prefs = UserPreferences();
  double xOffset = 0;
  double xx0ffset = 0;
  double yOffset = 0;
  double yyOffset = 0;
  double scaleFactor = 1;
  double sscaleFactor = 1;
  bool enable = true;
  DrawerClass item = DrawerItems.home;

  void open() => setState(() {
        xOffset = 270;
        xx0ffset = 260;
        yOffset = 50;
        yyOffset = 70;
        scaleFactor = 0.8;
        sscaleFactor = 0.75;
        enable = false;
      });

  void close() => setState(() {
        xOffset = 0;
        xx0ffset = 0;
        yyOffset = 0;
        yOffset = 0;
        scaleFactor = 1.0;
        sscaleFactor = 1.0;
        enable = true;
      });

  Widget buildDrawer(
          Responsive responsive, AuntenticateBloc auntenticateBloc) =>
      SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: const EdgeInsets.only(left: 10, top: 15, bottom: 30),
                onPressed: close,
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28,
                ),
                alignment: Alignment.centerLeft,
              ),
              DrawerHiddler(
                onSelectItem: (item) {
                  setState(() {
                    this.item = item;
                  });
                  close();
                },
              ),
            ],
          ),
          Container(
            height: responsive.hp(50),
          ),
          TextButton(
            onPressed: () {
              auntenticateBloc.singOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, '/splash', (route) => false);
            },
            child: Text(
              _prefs.locale == 'CO' ? 'Cerrar sesion' : 'Exit',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )
        ],
      ));

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    final auntenticateBloc =
        Provider.of<AuntenticateBloc>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Container(
        child: Stack(
          children: [
            buildDrawer(responsive, auntenticateBloc),
            buildPage(responsive),
          ],
        ),
      ),
    );
  }

  Widget buildPage(Responsive responsive) {
    return Stack(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(xx0ffset, yyOffset, 0)
            ..scale(sscaleFactor),
          child: ClipRRect(
              borderRadius: enable == true
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(16),
              child: Container(
                color: Colors.white.withOpacity(0.60),
                height: responsive.height,
                width: responsive.width,
              )),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(scaleFactor),
          child: ClipRRect(
              borderRadius: enable == true
                  ? BorderRadius.circular(0)
                  : BorderRadius.circular(20),
              child: getScren(item, context)),
        ),
      ],
    );
  }

  Widget getScren(DrawerClass item, BuildContext context) {
    final spotifybloc = Provider.of<SpotifyProvider>(context);
    switch (item) {
      case DrawerItems.home:
        return Home(
          open: open,
          onNextPage: () => spotifybloc.getCategoria(),
        );
      case DrawerItems.infoper:
        return InfoPerson(
          open: open,
        );
      default:
        return Home(
          open: open,
          onNextPage: () => spotifybloc.getCategoria(),
        );
    }
  }
}
