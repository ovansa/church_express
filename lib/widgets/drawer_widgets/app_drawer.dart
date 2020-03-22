import 'package:church_express/screens/bible.dart';
import 'package:church_express/screens/giving.dart';
import 'package:church_express/screens/notes.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/drawer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
              height: 80.0,
              decoration: BoxDecoration(
                color: appBarColor.withOpacity(0.1)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Menu",
                    style: drawerHeaderStyle,
                  ),
                ),
              ),
            ),
          createDrawerItem(
              icon: FontAwesomeIcons.userTie,
              text: Text(
                "Pastor's corner",
                style: drawerItemsStyle,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) => Bible(),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return new FadeTransition(
                              opacity: animation, child: child);
                        }));
              }),
          createDrawerItem(
              icon: FontAwesomeIcons.donate,
              text: Text(
                "Giving",
                style: drawerItemsStyle,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) => Giving(),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return new FadeTransition(
                              opacity: animation, child: child);
                        }));
              }),
          createDrawerItem(
              icon: FontAwesomeIcons.stickyNote,
              text: Text(
                "Notes",
                style: drawerItemsStyle,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (BuildContext context, _, __) =>
                            PastorCorner(),
                        transitionsBuilder:
                            (_, Animation<double> animation, __, Widget child) {
                          return new FadeTransition(
                              opacity: animation, child: child);
                        }));
              }),
        ],
      ),
    );
  }
}
