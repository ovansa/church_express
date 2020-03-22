import 'package:church_express/utils/colors.dart';
import 'package:flutter/material.dart';

Widget bottomNavigation () {
  int _currentIndex = 0;

  return BottomNavigationBar(
      backgroundColor: bottomNavBarColor,
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: new Icon(Icons.home),
          title: new Text('Welcome'),
        ),
        BottomNavigationBarItem(
          icon: new Icon(Icons.mail),
          title: new Text('Live Stream'),
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Location')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Bible')
        )
      ]);
}
