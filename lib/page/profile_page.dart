import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double getSmallDiameter(BuildContext context) => MediaQuery.of(context).size.width * 0.1;
  double getBigHeader(BuildContext context) => MediaQuery.of(context).size.width * 0.5;
  bool visible = true ;

  loadProgress(){

    if(visible == true){
      setState(() {
        visible = false;
      });
    }
    else{
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFEEEEEE),
        appBar: GradientAppBar(
          gradient: LinearGradient(colors: [Colors.red, Colors.purple]),
          title: Text("My Profile"),
        ),
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.28,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [Color(0xFFFF4891), Color.fromRGBO(233, 150, 122,1)],
                            begin: Alignment.bottomRight,
                            end: Alignment.topCenter
                        )
                    ),
                  ),
                ),
                Positioned(
                  left: -MediaQuery.of(context).size.width / 50,
                  top: -MediaQuery.of(context).size.height / 100,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Center(child:
                    Image.asset("images/logo.png")
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
              ],
            )
          ],
      ),



      ));
  }
}


