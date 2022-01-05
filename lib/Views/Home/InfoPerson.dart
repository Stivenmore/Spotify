import 'package:flutter/material.dart';

class InfoPerson extends StatefulWidget {
  final VoidCallback? open;
  InfoPerson({Key? key, this.open}) : super(key: key);

  @override
  _InfoPersonState createState() => _InfoPersonState();
}

class _InfoPersonState extends State<InfoPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
            onPressed: widget.open,
            icon: const Icon(
              Icons.dehaze_rounded,
              color: Color(0xff212121),
            )),
      ),
      body: Container(),
    );
  }
}
