import 'package:church_express/screens/note/providers/note_provider.dart';
import 'package:church_express/screens/videos/video_list_page.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String id;

  VideoPage({this.id});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  share(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share("Some text", subject: "Subject text", sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  final TextEditingController _textController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        NoteProvider.getNoteList();
        if (NoteProvider.db == null) {
          await NoteProvider.open();
        }
        await NoteProvider.db.query('Notes');

        final text = _textController.text;
        final title = _titleController.text;

        if (text != "") {
          if (title == "") {
            NoteProvider.insertData({'title': text.substring(0, 10), 'text': text});
          } else {
            NoteProvider.insertData({'title': title, 'text': text});
          }
          print("Saved ${text.toString()}");
        }
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
          key: _globalKey,
          appBar: AppBar(
            title: Text(
              "Video",
              style: appBarTextStyle,
            ),
            backgroundColor: appBarColor,
          ),
          body: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      print('Player is ready.');
                    },
                  ),
                ),
//                    Container(
//                      height: MediaQuery.of(context).size.height * 0.35,
//                      decoration: BoxDecoration(color: Colors.grey),
//                    ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 14.0,
                              backgroundImage: AssetImage("assets/sims.png"),
                            ),
                            SizedBox(width: 10.0),
                            Text("Get ready for greatness", style: GoogleFonts.montserrat(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300
                            ),),
                          ],
                        ),
                        IconButton(icon: Icon(Icons.share), iconSize: 18.0, onPressed: () {
                          share(context);
                        })
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    color: Colors.grey[350],
                    height: 1.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Note", style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 1.2
                          ),),
                        ),
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
//                              Text(
//                                "Title:",
//                                style: noteTitleStyle,
//                              ),
                                SizedBox(
                                  height: 1.0,
                                ),
                                TextField(
                                  controller: _titleController,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Title",
                                  ),
                                  style: noteTextStyle,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
//                              Text(
//                                "Text:",
//                                style: noteTitleStyle,
//                              ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextField(
                                  cursorColor: Colors.grey,
                                  controller: _textController,
                                  decoration: InputDecoration.collapsed(
                                    hintText: "Note",
                                  ),
                                  style: noteTextStyle,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 18,
                                ),
                                SizedBox(height: 20.0),
//                            Align(
//                              alignment: Alignment.center,
//                                child: NoteButton("Save", appBarColor, (){
//                                  final text = _textController.text;
//                                  final title = _textController.text.substring(0, 15);
//                                  NoteProvider.insertData({'title': title, 'text': text});
//                                  print("Saved ${text.toString()}");
//                                }))
                              ],
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
  Future<bool> _onWillPop() {
    final text = _textController.text;
    final title = _textController.text.substring(0, 15);
    NoteProvider.insertData({'title': title, 'text': text});
    return  Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) => VideoListPage(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(
                  opacity: animation, child: child);
            }));
  }
  
}
