

import 'package:flutter/material.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerClass.dart';

class DrawerItems {
  static const home = DrawerClass(title: 'Home', icon: Icons.home);
  static const infoper = DrawerClass(
      title: 'Informacion Personal', icon: Icons.person_outline_outlined);

  static final List<DrawerClass> all = [
    home,
    infoper,
  ];
}
