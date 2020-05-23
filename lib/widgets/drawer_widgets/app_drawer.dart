import 'package:church_express/screens/add_event.dart';
import 'package:church_express/screens/authentication/preferences.dart';
import 'package:church_express/screens/bible/bib/new_books_page.dart';
import 'package:church_express/screens/bible/books_page.dart';
import 'package:church_express/screens/give.dart';
import 'package:church_express/screens/home.dart';
import 'package:church_express/screens/giving.dart';
import 'package:church_express/screens/hustle/hustle_list.dart';
import 'package:church_express/screens/live_stream.dart';
import 'package:church_express/screens/live_stream2.dart';
import 'package:church_express/screens/notes.dart';
import 'package:church_express/screens/splash_screen/splash_screen.dart';
import 'package:church_express/screens/welcome.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/drawer_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            height: 85.0,
            decoration: BoxDecoration(color: appBarColor.withOpacity(0.9)),
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
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  createDrawerItem(
                      icon: FontAwesomeIcons.home,
                      text: Text(
                        "Home",
                        style: drawerItemsStyle,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => Welcome(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      }),
                  createDrawerItem(
                      icon: FontAwesomeIcons.bible,
                      text: Text(
                        "Bible",
                        style: drawerItemsStyle,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => NewBooksPage(),
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
                                pageBuilder: (BuildContext context, _, __) => Give(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      }),
                  createDrawerItem(
                      icon: FontAwesomeIcons.youtube,
                      text: Text(
                        "Live Stream",
                        style: drawerItemsStyle,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => LiveStream2(),
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
                                pageBuilder: (BuildContext context, _, __) => Notes(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      }),
                  createDrawerItem(
                      icon: FontAwesomeIcons.envelope,
                      text: Text(
                        "Hustles",
                        style: drawerItemsStyle,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => HustleList(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      }),
//          createDrawerItem(
//              icon: FontAwesomeIcons.stickyNote,
//              text: Text(
//                "Add Event",
//                style: drawerItemsStyle,
//              ),
//              onTap: () {
//                Navigator.of(context).pop();
//                Navigator.push(
//                    context,
//                    PageRouteBuilder(
//                        pageBuilder: (BuildContext context, _, __) => AddEvent(),
//                        transitionsBuilder:
//                            (_, Animation<double> animation, __, Widget child) {
//                          return new FadeTransition(
//                              opacity: animation, child: child);
//                        }));
//              }),

                ],
              ),
              SizedBox(height: 20.0,),
              createSignOutDrawerItem(
                  icon: FontAwesomeIcons.signOutAlt,
                  text: Text(
                    "Sign Out",
                    style: drawerSignOutItemsStyle,
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    print("Signed Out");
                    setLoggedInPreference(false).then((val){
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (BuildContext context, _, __) => SplashScreen(),
                              transitionsBuilder:
                                  (_, Animation<double> animation, __, Widget child) {
                                return new FadeTransition(
                                    opacity: animation, child: child);
                              }));
                    });
                  }),
//              ListTile(
//                title: Text('Log Out', style: drawerItemsStyle,),
//                onTap: () {
//                  FirebaseAuth.instance.signOut();
//                  print("Signed Out");
//                  setLoggedInPreference(false).then((val){
//                    Navigator.of(context).pop();
//                    Navigator.pushReplacement(
//                        context,
//                        PageRouteBuilder(
//                            pageBuilder: (BuildContext context, _, __) => SplashScreen(),
//                            transitionsBuilder:
//                                (_, Animation<double> animation, __, Widget child) {
//                              return new FadeTransition(
//                                  opacity: animation, child: child);
//                            }));
//                  });
//                },
//              ),
            ],
          ))
        ],
      ),
    );
  }
}
