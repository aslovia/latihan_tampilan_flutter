import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_tampilan_flutter/login_page.dart';
import 'package:latihan_tampilan_flutter/validation.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with Validation{
  bool visible = false ;

  final formKey = GlobalKey<FormState>();

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String name = '';
  String email = '';
  String password = '';

  Future userRegistration() async {
    setState(() {
      visible = true;
    });

    String email = _controllerEmail.text;
    String username = _controllerUsername.text;
    String password = _controllerPassword.text;

    //koneksi ke server untuk register user
    var url = 'http://192.168.1.15/brosis/register.php';

    //menyimpan data user
    var dataUser = {'email':email, 'username':username, 'password':password};

    //memanggil WEB API
    var response = await http.post(url, body: json.encode(dataUser));

    //mendapatkan respon server ke variabel
    var message = jsonDecode(response.body);

    //menghilangkan CircularProgressIndicator jika berhasil
    if (message == "Pengguna Berhasil Terdaftar. Silahkan Login")
    {
      setState(() {
        visible = false;
      });

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: (){
                    Navigator.of(context).pop(context);
                  },)
              ],
            );
          }
      );
    }

    else
    {
      setState(() {
        visible = false;
      });

      //menampilkan alert dialog dengan respon JSON
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text("OK"),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },)
              ],
            );
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFFEEEEEE),
        body: Form(
          key: formKey,
          child: Container(
            color: Color(0xFFFEEEEEE),
            padding: EdgeInsets.all(20),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset("images/logo.png",
                          width: 120,
                          height: 120
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.0),
                        child: Text("REGISTRATION", style: TextStyle(fontSize: 20, color: Colors.pink)),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 30, 20, 10),
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 25),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                  controller: _controllerEmail,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.email, color: Color(0xFFFF4891)),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Color(0xFFFF4891)),
                                      ),
                                      labelText: "Email :",
                                      labelStyle: TextStyle(color: Color(0xFFFF4891))
                                  ),
                                  validator:validateEmail,
                                  onSaved: (String value) {
                                    email = value;
                                  }
                              ),
                              TextFormField(
                                  controller: _controllerUsername,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person, color: Color(0xFFFF4891)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFFF4891)),
                                    ),
                                    labelText: "Username :",
                                    labelStyle: TextStyle(color: Color(0xFFFF4891)),
                                  ),
                                  validator:validateName,
                                  onSaved: (String value) {
                                    name = value;
                                  }
                              ),
                              TextFormField(
                                  controller: _controllerPassword,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xFFFF4891)),
                                    ),
                                    labelText: "Password :",
                                    labelStyle: TextStyle(color: Color(0xFFFF4891)),
                                  ),
                                  validator:validatePassword,
                                  onSaved: (String value) {
                                    password = value;
                                  },
                                  obscureText: true
                              ),
//                                TextFormField(
//                                    decoration: InputDecoration(
//                                      icon: Icon(Icons.vpn_key, color: Color(0xFFFF4891)),
//                                      focusedBorder: UnderlineInputBorder(
//                                        borderSide: BorderSide(color: Color(0xFFFF4891)),
//                                      ),
//                                      labelText: "Confirm Password :",
//                                      labelStyle: TextStyle(color: Color(0xFFFF4891)),
//                                    ),
//                                  validator:validatePassword,
//                                  onSaved: (String value) {
//                                    password = value;
//                                  },
//                                  obscureText: true,
//                                )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 40,
                          child: Container(
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.pinkAccent,
                                onTap: () {
                                  if (formKey.currentState.validate()) {
                                    formKey.currentState.save();
                                    userRegistration();
                                  }
                                },
                                child: Center(
                                    child: Text("REGISTER",
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
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("DO YU HAVE ACCOUNT? ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: Colors.grey),
                              ),
                              FlatButton(
                                onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                  return LoginPage();
                                }));} ,
                                child: Text("LOGIN NOW",
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
        ),
      ),
    );
  }
}
