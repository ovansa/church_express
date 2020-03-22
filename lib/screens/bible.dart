import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';

class Bible extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Bible", style: appBarTextStyle,),
          backgroundColor: appBarColor,
          leading: IconButton(icon: Image.asset("assets/icons/drawer_icon.png"), onPressed: () {
            _globalKey.currentState.openDrawer();
          })
      ),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.blueGrey,
      ),
    );
  }

}
