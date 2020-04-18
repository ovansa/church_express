import 'package:firebase_database/firebase_database.dart';

class EventModel {
  String key;
  String eventTitle;
  String date;
  String time;
  String imgUrl;

  EventModel(this.eventTitle, this.date, this.time, this.imgUrl);

  EventModel.fromSnapshot(DataSnapshot snapshot) :
      key = snapshot.key,
  eventTitle = snapshot.value["eventTitle"],
  date = snapshot.value["date"],
  time = snapshot.value["time"],
  imgUrl = snapshot.value["imgUrl"];

  toJson() {
    return {
      "eventTitle": eventTitle,
      "date": date,
      "time": time,
      "imgUrl": imgUrl
    };
  }
}