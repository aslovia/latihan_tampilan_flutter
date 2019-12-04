import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:latihan_tampilan_flutter/page/business_page.dart';
import 'package:latihan_tampilan_flutter/page/event_page.dart';
import 'package:latihan_tampilan_flutter/page/landing_page.dart';
import 'package:latihan_tampilan_flutter/page/news_page.dart';
import 'package:latihan_tampilan_flutter/page/profile_page.dart';

void main() => runApp(MaterialApp(home: NavigationPage()));

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int pageIndex = 0;
  GlobalKey _navigationPageKey  = GlobalKey();

  final BusinessPage _businessPage = BusinessPage();
  final EventPage _eventPage = EventPage();
  final LandingPage _landingPage = LandingPage();
  final NewsPage _newsPage = NewsPage();
  final ProfilePage _profilePage = ProfilePage();

  Widget _showPage = new LandingPage();

  Widget _choosePage (int page) {
      switch(page) {
        case 0:
          return _landingPage;
          break;
        case 1:
          return _newsPage;
          break;
        case 2 :
          return _eventPage;
          break;
        case 3 :
          return _businessPage;
        case 4:
          return _profilePage;
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _navigationPageKey,
          index : pageIndex ,
          height: 50.0,
          items: <Widget>[
            Image(image: AssetImage("images/home.png"), fit: BoxFit.none,),
            Image(image: AssetImage("images/newspaper.png"), fit: BoxFit.none,),
            Image(image: AssetImage("images/event.png"), fit: BoxFit.none,),
            Image(image: AssetImage("images/directory.png"), fit: BoxFit.none,),
            Icon(Icons.perm_identity, size: 30),

          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Color(0xFFFEEEEEE),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int index) {
            setState(() {
              _showPage = _choosePage(index);
            });
          },
        ),
        body: Container(
          child: Center(
            child: _showPage,
          ),
        ));
  }
}