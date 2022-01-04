import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify/Domain/Provider/AutenticateProvider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AutenticateProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.user!.email!),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () async {
                    provider.singOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/splash', (route) => false);
                  },
                  child: Container(
                    width: 90,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                        child: Text(
                      'Salir',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
