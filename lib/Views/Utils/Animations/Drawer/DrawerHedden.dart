import 'package:flutter/material.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerClass.dart';
import 'package:spotify/Views/Utils/Animations/Drawer/DrawerItems.dart';


class DrawerHiddler extends StatelessWidget {
  final ValueChanged<DrawerClass> onSelectItem;

  const DrawerHiddler({Key? key, required this.onSelectItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [buildDrawerItems(context)],
      ),
    );
  }

  Widget buildDrawerItems(BuildContext context) {
    return Column(
        children: DrawerItems.all
            .map((item) => Container(
                  width: 250,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                    leading: Container(
                        padding: EdgeInsets.all(0),
                        width: 22,
                        child: Icon(item.icon, color: Colors.white)),
                    title: Text(
                      item.title,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          wordSpacing: -0.5),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    onTap: () => onSelectItem(item),
                  ),
                ))
            .toList());
  }
}
