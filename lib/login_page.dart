import 'dart:convert';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latihan_tampilan_flutter/page/landing_page.dart';
import 'package:latihan_tampilan_flutter/navigation_page.dart';
import 'package:latihan_tampilan_flutter/page/profile_page.dart';
import 'package:latihan_tampilan_flutter/register_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double getSmallDiameter(BuildContext context) => MediaQuery.of(context).size.width * 2/3;
  double getBigDiameter(BuildContext context) => MediaQuery.of(context).size.width * 7/8;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool _isPasswordShow = true;
  bool visible = false;

  Future userLogin() async
  {
    setState(() {
      visible = true;
    });

    String email = _controllerEmail.text;
    String password = _controllerPassword.text;

    var url = "http://192.168.1.15/brosis/login.php";

    var dataLogin = {'email':email, 'password':password};

    var response = await http.post(url,body: json.encode(dataLogin));

    var message = jsonDecode(response.body);

    if (message == "Login Berhasil")
    {
      setState(() {
        visible = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return NavigationPage();
      }));
    }

    else
    {
      setState(() {
        visible = false;
      });

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog (
              title: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }



  void _passwordVisibility() {
    setState(() {
      _isPasswordShow = !_isPasswordShow;
    });

  }

  void _openInstagramView() {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('https://www.instagram.com/brosispku/'),
        package: 'com.instagram.android');
    intent.launch();
  }

  void _openFacebookView() {
    final AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull('https://www.facebook.com/brosispku/'),
        package: 'com.instagram.android');
    intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color.fromRGBO(255, 160, 122, 0.3)
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFEEEEEE),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              right: -getSmallDiameter(context)/3,
              top: -getSmallDiameter(context)/3,
              child: Container(
                child: Text("LOGIN"),
                width: getSmallDiameter(context),
                height: getSmallDiameter(context),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color(0xFFFF4891), Color.fromRGBO(233, 150, 122,1)],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter
                    )
                ),
              ),
            ),
            Positioned(
              left: -getBigDiameter(context) / 4,
              top: -getBigDiameter(context) / 4,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Center(child:
                Image.asset("images/logo.png")
                ),
                width: getBigDiameter(context),
                height: getBigDiameter(context),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Color.fromRGBO(233, 150, 122,1), Color(0xFFFF4891)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 300, 20, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _controllerEmail,
                          decoration: InputDecoration(
                              icon: Icon(Icons.email, color: Color(0xFFFF4891)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFF4891)),
                              ),
                              labelText: "Email :",
                              labelStyle: TextStyle(color: Color(0xFFFF4891)),
                              hintText: 'email@example.com'
                          ),
                        ),
                        TextFormField(
                          controller: _controllerPassword,
                          decoration: InputDecoration(
                              icon: Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFF4891)),
                              ),
                              labelText: "Password :",
                              hintText: 'masukan password anda ',
                              labelStyle: TextStyle(color: Color(0xFFFF4891)),
                              suffixIcon: GestureDetector(
                                onTap: _passwordVisibility,
                                child: Icon(
                                    _isPasswordShow ? Icons.visibility_off : Icons.visibility,
                                    color: _isPasswordShow ? Colors.grey : Colors.blue
                                ),
                              ),
                              isDense: true
                          ),
                          autofocus: false,
                          obscureText: _isPasswordShow,
                          //initialValue: '',
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment(0.8, 0.6),
                      child: Text("FORGOT PASSWORD?",
                          style: TextStyle(color: Color(0xFFFF4891), fontSize: 11))
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          child: Container(
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.pinkAccent,
                                onTap: userLogin,
                                child: Center(
                                    child: Text("LOGIN",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700)
                                    )
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(colors: [Color(0xFFB226B2), Color(0xFFFF4891)])
                            ),
                          ),
                        ),
                        FloatingActionButton(
                            onPressed: _openInstagramView ,
                            elevation: 0,
                            child: Image(image: AssetImage("images/instagram.png"),),
                            backgroundColor: Colors.transparent,
                            heroTag: null
                        ),
                        FloatingActionButton(
                            onPressed: _openFacebookView ,
                            elevation: 0,
                            child: Image(image: AssetImage("images/facebook.png"),),
                            backgroundColor: Colors.transparent,
                            heroTag: null
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("DON'T HAVE ACCOUNT? ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: Colors.grey),
                          ),
                          FlatButton(
                            onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return RegisterPage();
                            }));} ,
                            child: Text("REGISTER NOW",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.pink),
                            ),
                          )
                        ],
                      ),
                      Visibility(
                          visible: visible,
                          child: Container(
                              child: CircularProgressIndicator()
                          )
                      )
                    ],
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}