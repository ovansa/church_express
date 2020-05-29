import 'package:church_express/screens/welcome/articles_page.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Welcome3 extends StatefulWidget {
  @override
  _WelcomePage3State createState() => _WelcomePage3State();
}

class _WelcomePage3State extends State<Welcome3> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
          title: Text(
            "Home 2",
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Container(
                height: 110.0,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Accelerate TV", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Faith Blog", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Fathers TV", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Mothers Day", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Life Hacks", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => ArticlesPage(),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Column(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40.0,
                            backgroundImage: AssetImage("assets/sims.png"),
                          ),
                          SizedBox(height: 10.0,),
                          Text("Remote Work", style: welcomeDateTitle,)
                        ],
                      ),
                    ),
                    SizedBox(width: 5.0,),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
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
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
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
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
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
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return  SystemNavigator.pop();
  }
}
