import 'package:church_express/screens/authentication/login.dart';
import 'package:church_express/screens/authentication/sign_up.dart';
import 'package:church_express/screens/authentication/some.dart';
import 'package:church_express/screens/login/login_signup.dart';
import 'package:church_express/screens/login/root_page.dart';
import 'package:church_express/screens/notes.dart';
import 'package:church_express/screens/test_for_drawer.dart';
import 'package:church_express/screens/welcome.dart';
import 'package:church_express/services/firebase_auth.dart';
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
        title: 'Flutter Demo',
        home: Login(),
      ),
    );
  }
}
