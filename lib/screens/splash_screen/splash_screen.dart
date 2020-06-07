import 'dart:async';

import 'package:church_express/screens/authentication/preferences.dart';
import 'package:church_express/screens/authentication/sign_up.dart';
import 'package:church_express/screens/welcome/welcome.dart';
import 'package:church_express/screens/welcome/welcome2.dart';
import 'package:church_express/screens/welcome/welcome3.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      getLoggedInPreference().then((val){
        print(val);
        if (val == null || val == false) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignUp()));
        } else if (val == true) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => Welcome3()));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFDA1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Opacity(
              opacity: 0.9,
                child: Image.asset("assets/church_logo.png", height: 150.0,)),
            SizedBox(height: 20.0,),
            Text("Welcome to Church", style: splashHeaderStyle,),
            SizedBox(height: 5.0,),
            Text("Christ our solid rock", style: splashDescrStyle,)
          ],
        ),
      ),
    );
  }
}
