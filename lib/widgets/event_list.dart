import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:church_express/models/events.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventItem extends StatefulWidget {
  @override
  _EventItemState createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  final List<Events> events = [
    Events("assets/experience.png", "6:00 pm - Till Dawn", "March 6, 2020", "A musical concert connecting people to God"),
    Events("assets/experience.png", "6:00 pm - 7:00pm", "May 10, 2020", "A musical concert connecting people to God"),
    Events("assets/experience.png", "7:00 pm - 11:00pm", "June 19, 2020", "A musical concert connecting people to God"),
    Events("assets/experience.png", "8:00 pm - Till Dawn", "December 6, 2020", "A musical concert connecting people to God")
  ];

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index){
          Event addEvent = Event(
            title: events[index].title,
            description: events[index].title,
            location: "Lagos Island",
            startDate: DateTime.now(),
            endDate: DateTime.now().add(Duration(days: 1)),
            allDay: false,
          );
      return Column(
        children: <Widget>[
          Container(
            height: 220,
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
                          horizontal: 10.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            events[index].title,
                            style: welcomeListTitle,
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    events[index].date,
                                    style: welcomeDateTitle,
                                  ),
                                  Text(
                                    events[index].duration,
                                    style: welcomeTimeTitle,
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                    Add2Calendar.addEvent2Cal(addEvent).then((success) {
                                      scaffoldState.currentState.showSnackBar(
                                          SnackBar(content: Text(success ? 'Success' : 'Error')));
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
                                      borderRadius: BorderRadius.circular(5.0)),
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
                          image: AssetImage(events[index].image),
                          fit: BoxFit.fill),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10,)
        ],
      );
    });
  }
}
