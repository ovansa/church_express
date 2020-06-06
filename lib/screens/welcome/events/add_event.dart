import 'dart:io';
import 'dart:wasm';
import 'package:church_express/models/welcome/event_model.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:church_express/screens/authentication/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  EventModel event;

  String fileType = '';
  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';
  
  DateTime _dateTime;
  String _date;
  TimeOfDay _timeOfDay;
  String _time;

  final FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference;

  @override
  void initState() {
    super.initState();

    event = EventModel("", "", "", "");
    databaseReference = database.reference().child("event_list");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
          title: Text(
            "Welcome",
            style: appBarTextStyle,
          ),
          backgroundColor: appBarColor,
          leading: IconButton(
              icon: Image.asset("assets/icons/drawer_icon.png"),
              onPressed: () {
                _globalKey.currentState.openDrawer();
              })),
      drawer: AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Upload Events",
                  style: welcomeTitle,
                ),
              ),
              Form(
                  key: formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.title),
                        title: TextFormField(
                          initialValue: "",
                          onSaved: (val) => event.eventTitle = val,
                          validator: (val) =>
                          val == "" ? "Empty not allowed" : null,
                        ),
                      ),
//                      ListTile(
//                        leading: Icon(Icons.message),
//                        title: TextFormField(
//                          initialValue: "",
//                          onSaved: (val) => userModel.email = val,
//                          validator: (val) =>
//                          val == "" ? "Empty not allowed" : null,
//                        ),
//                      ),
                      SizedBox(height: 15.0,),
                      ListTile(
                        title: Text('Image', style: TextStyle(color: Colors.white),),
                        leading: Icon(Icons.image, color: Colors.redAccent,),
                        onTap: () {
                          setState(() {
                            fileType = 'image';
                          });
                          filePicker(context);
                        },
                      ),
                      SizedBox(height: 15.0,),
                      Text(_date == null ? "Nothing has been selected" : _date),
                      FlatButton(onPressed: () {
                        showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2100)).then((date) {
                          setState(() {
                            _dateTime = date;
//                            _date = DateFormat('dd/MM/yyyy').format(date);
                            _date = date.toUtc().toString();
//                            _date = DateFormat.yMMMd().format(date);
                            event.date = _date;
                          });
                        });
                      }, child: Text("Pick a date")),
                      SizedBox(height: 15.0,),
                      Text(_time == null ? "Nothing has been selected" : _time),
                      FlatButton(onPressed: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).then((time) {
                          setState(() {
                            MaterialLocalizations localizations = MaterialLocalizations.of(context);
                            String formattedTime = localizations.formatTimeOfDay(time,
                                alwaysUse24HourFormat: false);
//                            _timeOfDay = TimeOfDay.fromDateTime(DateTime.parse(time.toString()));
                            _time = formattedTime;
                            event.time = _time;
                          });
                        });
                      }, child: Text("Select time")),
                      FlatButton(
                        onPressed: () {
                          handleSubmit();
                        },
                        child: Text("Post"),
                        color: Colors.redAccent,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void handleSubmit() {
    final FormState form = formKey.currentState;
    form.save();

    try {
      databaseReference.push().set(event.toJson()).then((_) {
        print("Submitted successfully");
      });
    } catch (error) {
      print(error.message);
    }
  }

  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'audio') {
        file = await FilePicker.getFile(type: FileType.audio);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'video') {
        file = await FilePicker.getFile(type: FileType.video);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'pdf') {
        file = await FilePicker.getFile(type: FileType.custom);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
      if (fileType == 'others') {
        file = await FilePicker.getFile(type: FileType.any);
        fileName = p.basename(file.path);
        setState(() {
          fileName = p.basename(file.path);
        });
        print(fileName);
        _uploadFile(file, fileName);
      }
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }
  Future<Void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("images/$filename");
    }
    if (fileType == 'audio') {
      storageReference =
          FirebaseStorage.instance.ref().child("audio/$filename");
    }
    if (fileType == 'video') {
      storageReference =
          FirebaseStorage.instance.ref().child("videos/$filename");
    }
    if (fileType == 'pdf') {
      storageReference =
          FirebaseStorage.instance.ref().child("pdf/$filename");
    }
    if (fileType == 'others') {
      storageReference =
          FirebaseStorage.instance.ref().child("others/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    event.imgUrl = url;
  }
}
