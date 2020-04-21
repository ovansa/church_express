import 'package:church_express/providers/note_provider.dart';
import 'package:church_express/screens/add_note.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(
          "My Notes",
          style: appBarTextStyle,
        ),
        backgroundColor: appBarColor,
        leading: IconButton(
            icon: Image.asset("assets/icons/drawer_icon.png"),
            onPressed: () {
              _globalKey.currentState.openDrawer();
            }),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              FontAwesomeIcons.search,
//              color: Color(0xFFFFFFFF),
//              size: 14.0,
//            ),
//          )
//        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final notes = snapshot.data;
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (BuildContext context, _, __) => AddNote(NoteMode.Editing, notes[index]),
                                transitionsBuilder:
                                    (_, Animation<double> animation, __, Widget child) {
                                  return new FadeTransition(
                                      opacity: animation, child: child);
                                }));
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 13.0, right: 13.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: floatButtonColor,
                                        radius: 3.0,
                                      ),
                                      SizedBox(width: 5.0,),
                                      _NoteTitle(notes[index]['title']),
                                    ],
                                  )
//                                  _TimeTitle("09-10-2019")
                                ],
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              // ignore: missing_return
                              _NoteText(notes[index]['text'])
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: floatButtonColor,
          child: Icon(
            FontAwesomeIcons.plus,
            color: Color(0xFF000000),
            size: 14.0,
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) => AddNote(NoteMode.Adding, null),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return new FadeTransition(
                          opacity: animation, child: child);
                    }));
          }),
    );
  }
}

class _NoteText extends StatelessWidget {
  final String _text;

  _NoteText(this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: noteTextStyle,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _NoteTitle extends StatelessWidget {
  final String _title;

  _NoteTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: noteTitleStyle,
    );
  }
}

class _TimeTitle extends StatelessWidget {
  final String _time;

  _TimeTitle(this._time);

  @override
  Widget build(BuildContext context) {
    return Text(
      _time,
      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400),
    );
  }
}