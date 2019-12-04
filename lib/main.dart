import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latihan_tampilan_flutter/launcher/launcher_page.dart';

//void main() => runApp(MyApp());

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(new MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BroSisPku',
      theme: ThemeData(),
      home: LauncherPage(),
    );
  }
}
