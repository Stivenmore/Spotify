import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spotify/Domain/Models/Hive/UserModel.dart';
import 'package:spotify/Domain/Shared/prefs.dart';
import 'package:spotify/Views/Utils/Responsive/responsive.dart';

class InfoPerson extends StatefulWidget {
  final VoidCallback? open;
  InfoPerson({Key? key, this.open}) : super(key: key);

  @override
  _InfoPersonState createState() => _InfoPersonState();
}

class _InfoPersonState extends State<InfoPerson> {
  final box = Hive.box<UserModel>('User');
  final _prefs = UserPreferences();
  bool? switchValue;

  @override
  Widget build(BuildContext context) {
    final boxkeylast = box.keys.last;
    final user = box.get(boxkeylast) as UserModel;
    Color text = const Color(0xff3A3B55);
    Responsive responsive = Responsive(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: widget.open,
              icon: const Icon(
                Icons.dehaze_rounded,
                color: Color(0xff3A3B55),
              )),
          title: const Text(
            'Mis datos',
            style: TextStyle(
                color: Color(0xff3A3B55), fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
            height: responsive.height,
            width: responsive.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: responsive.hp(1),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: responsive.hp(10),
                        ),
                        Text(
                          user.name != ''
                              ? ' ${user.name} ${user.lastname}'
                              : 'Usuario',
                          style: TextStyle(
                              color: text,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                            height: 62,
                            width: responsive.wp(80),
                            decoration: BoxDecoration(
                                color: const Color(0xffF3F5F7),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xffeeeeee))),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 10),
                                child: Text(user.identification.toString(),
                                    style: const TextStyle(fontSize: 18)),
                              ),
                            )),
                        const SizedBox(
                          height: 18,
                        ),
                        Container(
                            height: 62,
                            width: responsive.wp(80),
                            decoration: BoxDecoration(
                                color: const Color(0xffF3F5F7),
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: const Color(0xffeeeeee))),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 10),
                                child: Text(user.email.toString(),
                                    style: const TextStyle(fontSize: 18)),
                              ),
                            )),
                        SizedBox(
                          height: responsive.hp(10),
                        ),
                        const Text('Localidad Colombia'),
                        CupertinoSwitch(
                          activeColor: Colors.purple,
                          value: _prefs.locale == 'CO' ? true : false,
                          onChanged: (value) {
                            setState(() {
                              switchValue = value;
                            });
                            if (switchValue == true) {
                              _prefs.locale = 'CO';
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/splash', (route) => false);
                            } else {
                              _prefs.locale = 'AU';
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/splash', (route) => false);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
