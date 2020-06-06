import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome2 extends StatefulWidget {

  @override
  _Welcome2State createState() => _Welcome2State();
}

class _Welcome2State extends State<Welcome2> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _globalKey,
        appBar: AppBar(
            title: Text(
              "Home",
              style: appBarTextStyle,
            ),
            backgroundColor: appBarColor,
            leading: IconButton(
                icon: Image.asset("assets/icons/drawer_icon.png"),
                onPressed: () {
                  _globalKey.currentState.openDrawer();
                })),
        drawer: AppDrawer(),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 70.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "The events of event The events of event The events of event.",
                                  style: welcomeListTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "22th December, 2019",
                                          style: welcomeDateTitle,
                                        ),
                                        Text(
                                          "5:00:00 PM",
                                          style: welcomeTimeTitle,
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
//                                      Add2Calendar.addEvent2Cal(addEvent)
//                                          .then((success) {
//                                        scaffoldState.currentState.showSnackBar(
//                                            SnackBar(
//                                                content: Text(success
//                                                    ? 'Success'
//                                                    : 'Error')));
//                                      });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          child: Text("Add to Calender",
                                              style: GoogleFonts.montserrat(
                                                  color: floatButtonColor,
                                                  fontSize: 10.0)),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF262F3A),
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 150.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            image: DecorationImage(
                                image: AssetImage("assets/experience.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 250.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics( ),
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/experience.png"), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                child: Text(
                                    "Mary Mabgable:\nThe return of Jerusalem", style: welcomeArticlesTextStyle,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/experience.png"), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                child: Text(
                                  "Do you know Jesus?", style: welcomeArticlesTextStyle,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/experience.png"), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                child: Text(
                                  "The History of the Church", style: welcomeArticlesTextStyle,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      Container(
                        width: 150.0,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("assets/experience.png"), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 10.0,
                                right: 0.0,
                                top: 10.0,
                                child: Text(
                                  "Mary Mabgable:\nThe return of Jerusalem", style: welcomeArticlesTextStyle,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0,),
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Lecrea releases new album Anomaly",
                                  style: welcomeListTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "22th December, 2019",
                                          style: welcomeDateTitle,
                                        ),
//                                      Text(
//                                        "5:00:00 PM",
//                                        style: welcomeTimeTitle,
//                                      ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
//                                      Add2Calendar.addEvent2Cal(addEvent)
//                                          .then((success) {
//                                        scaffoldState.currentState.showSnackBar(
//                                            SnackBar(
//                                                content: Text(success
//                                                    ? 'Success'
//                                                    : 'Error')));
//                                      });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          child: Text("Pre-order now!",
                                              style: GoogleFonts.montserrat(
                                                  color: floatButtonColor,
                                                  fontSize: 10.0)),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF262F3A),
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 160.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            image: DecorationImage(
                                image: AssetImage("assets/anomaly.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 230,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.withOpacity(0.2)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.0),
                                  bottomRight: Radius.circular(20.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Lecrea releases new album Anomaly",
                                  style: welcomeListTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "22th December, 2019",
                                          style: welcomeDateTitle,
                                        ),
//                                      Text(
//                                        "5:00:00 PM",
//                                        style: welcomeTimeTitle,
//                                      ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
//                                      Add2Calendar.addEvent2Cal(addEvent)
//                                          .then((success) {
//                                        scaffoldState.currentState.showSnackBar(
//                                            SnackBar(
//                                                content: Text(success
//                                                    ? 'Success'
//                                                    : 'Error')));
//                                      });
                                      },
                                      child: Container(
                                        height: 20.0,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 10.0),
                                          child: Text("Pre-order now!",
                                              style: GoogleFonts.montserrat(
                                                  color: floatButtonColor,
                                                  fontSize: 10.0)),
                                        ),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF262F3A),
                                            borderRadius:
                                            BorderRadius.circular(5.0)),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          height: 160.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0)),
                            image: DecorationImage(
                                image: AssetImage("assets/anomaly.png"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return  SystemNavigator.pop();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
