import 'package:church_express/practice_loading/firstscreen.dart';
import 'package:church_express/screens/authentication/login.dart';
import 'package:church_express/screens/splash_screen/splash_screen.dart';
import 'package:church_express/widgets/inherited_widget/inherited_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NoteInheritedWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Church Express',
        home: SplashScreen(),
      ),
    );
  }
}
