import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as cal;
import 'package:church_express/models/events.dart';
import 'package:church_express/screens/authentication/event_model.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as eve;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}

class EventItem2 extends StatefulWidget {
  @override
  _EventItem2State createState() => _EventItem2State();
}

class _EventItem2State extends State<EventItem2> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  List<EventModel> eventList = List();

  @override
  void initState() {
    super.initState();

    databaseReference = database.reference().child("event_list");
    databaseReference.onChildAdded.listen(_onEntryAdded);
  }

//  final List<Events> events = [
//    Events("assets/experience.png", "6:00 pm - Till Dawn", "March 6, 2020", "A musical concert connecting people to God"),
//    Events("assets/experience.png", "6:00 pm - 7:00pm", "May 10, 2020", "A musical concert connecting people to God"),
//    Events("assets/experience.png", "7:00 pm - 11:00pm", "June 19, 2020", "A musical concert connecting people to God"),
//    Events("assets/experience.png", "8:00 pm - Till Dawn", "December 6, 2020", "A musical concert connecting people to God")
//  ];

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      physics: BouncingScrollPhysics(),
        query: databaseReference,
        reverse: false,
        itemBuilder:
            (_, DataSnapshot snapshot, Animation<double> animation, int index) {
        if(snapshot.value != null) {
          cal.Event addEvent = cal.Event(
            title: eventList[index].eventTitle,
            description: eventList[index].eventTitle,
            location: 'Flutter app',
            startDate: DateTime.parse(eventList[index].date).toUtc(),
            endDate: DateTime.parse(eventList[index].date).toUtc(),
            allDay: false,
          );

//          print(eventList[index].date);
//          DateTime d = DateUtil().formattedDate(DateTime.parse(eventList[index].date).toLocal());
//          print(DateTime.parse(eventList[index].date+" "+eventList[index].time).toUtc());
          print(DateFormat.yMMMd().format(DateTime.parse(eventList[index].date).toUtc()));




//          print(formatDate(DateTime.parse(eventList[index].date), [yyyy, '/', mm, '/', dd,]));
          void convertDateFromString(String strDate){
//            DateTime todayDate = DateTime.parse("7/10/1996 10:07:23");
//            print(todayDate);
            print(DateFormat.yMMMd().parse(eventList[index].date).millisecondsSinceEpoch);
            Timestamp stamp = Timestamp.fromDate(DateFormat.yMMMd().parse(strDate));
            print(stamp);
//            print(formatDate(todayDate, [yyyy, '/', mm, '/', dd, ' ', hh, ':', nn, ':', ss, ' ', am]));
          }

//          convertDateFromString(eventList[index].date);

          return Column(
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
                                eventList[index].eventTitle,
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
                                        DateFormat.yMMMd().format(DateTime.parse(eventList[index].date).toUtc()),
                                        style: welcomeDateTitle,
                                      ),
                                      Text(
                                        eventList[index].time,
                                        style: welcomeTimeTitle,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Add2Calendar.addEvent2Cal(addEvent)
                                          .then((success) {
                                        scaffoldState.currentState.showSnackBar(
                                            SnackBar(
                                                content: Text(success
                                                    ? 'Success'
                                                    : 'Error')));
                                      });
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
                              image: NetworkImage(eventList[index].imgUrl),
                              fit: BoxFit.fill),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(appBarColor),),
          );
        }

        });
  }

  void _onEntryAdded(eve.Event event) {
    setState(() {
      eventList.add(EventModel.fromSnapshot(event.snapshot));
    });
  }
}
