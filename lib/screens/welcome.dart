import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/bottom_nav_widget/bottom_navigation_bar.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text("Welcome", style: appBarTextStyle,),
        backgroundColor: appBarColor,
        leading: IconButton(icon: Image.asset("assets/icons/drawer_icon.png"), onPressed: () {
          _globalKey.currentState.openDrawer();
        })
      ),
      drawer: AppDrawer(),
      body: Center(
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: bottomNavBarColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: activeTabColor,
          unselectedItemColor: inactiveTabColor,
          selectedFontSize: 12.0,
          unselectedFontSize: 10.0,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.cross, size: 16.0,),
              title: new Text('Welcome', style: bottomNavBarTextStyle,),
            ),
            BottomNavigationBarItem(
              icon: new Icon(FontAwesomeIcons.playCircle, size: 16.0,),
              title: new Text('Live Stream', style: bottomNavBarTextStyle,),
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.mapMarkerAlt, size: 16.0,),
                title: Text('Location', style: bottomNavBarTextStyle,)
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.bible, size: 16.0,),
                title: Text('Bible', style: bottomNavBarTextStyle,)
            )
          ]),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
