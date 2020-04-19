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
        child: Text("Menu"),
      ),
    ),
  );
}

Widget createDrawerItem({IconData icon, Text text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(padding: EdgeInsets.only(left: 8.0),
        child: text,)
      ],
    ),
    onTap: onTap,
  );
}
