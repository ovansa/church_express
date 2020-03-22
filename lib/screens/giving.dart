import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Giving extends StatelessWidget {
  static const String routeName = '/giving';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giving"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("Giving"),
      ),
    );
  }
}
