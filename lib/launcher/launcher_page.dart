import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latihan_tampilan_flutter/login_page.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => new _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    launchingStart();
  }

  launchingStart() async {
    var duration = const Duration(seconds: 5);

    return new Timer (duration,() {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background_splash.jpg'),
                fit: BoxFit.fitHeight
              )
            ),
          ),
          Container(
            color: Color.fromRGBO(112, 128, 144, 0.8),
          ),
          Container(
            child: Image.asset("images/logo.png"),
          )
        ],
      ),
    );
  }
}