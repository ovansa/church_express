import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PastorCorner extends StatelessWidget {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
          title: Text("My Notes", style: appBarTextStyle,),
          backgroundColor: appBarColor,
          leading: IconButton(icon: Image.asset("assets/icons/drawer_icon.png"), onPressed: () {
            _globalKey.currentState.openDrawer();
          }),
        actions: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.search, color: Color(0xFFFFFFFF), size: 14.0,),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: floatButtonColor,
        child: Icon(FontAwesomeIcons.plus, color: Color(0xFF000000), size: 14.0,),
          onPressed: (){
        print("Create note");
      }),
    );
  }
}

