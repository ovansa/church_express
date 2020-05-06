import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createHeader() {
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: Container(
      height: 20,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("Menu", style: drawerHeaderStyle,),
      ),
    ),
  );
}

Widget createDrawerItem({IconData icon, Text text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, size: 14,),
        Padding(padding: EdgeInsets.only(left: 8.0),
        child: text,)
      ],
    ),
    onTap: onTap,
  );
}

Widget createSignOutDrawerItem({IconData icon, Text text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon, size: 12,),
        Padding(padding: EdgeInsets.only(left: 8.0),
          child: text,)
      ],
    ),
    onTap: onTap,
  );
}