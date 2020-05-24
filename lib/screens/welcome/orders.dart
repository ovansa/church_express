import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
        itemBuilder: (context, index){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
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
      );
    });
  }
}
