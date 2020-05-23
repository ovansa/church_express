import 'package:church_express/screens/add_note.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String id;

  VideoScreen({this.id});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          body: SingleChildScrollView(

            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Column(
                children: <Widget>[
//            Container(
//              height: MediaQuery.of(context).size.height * 0.35,
//              child: YoutubePlayer(
//                controller: _controller,
//                showVideoProgressIndicator: true,
//                onReady: () {
//                  print('Player is ready.');
//                },
//              ),
//            ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Title:",
                              style: noteTitleStyle,
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            TextField(
//                  controller: _titleController,
                              cursorColor: Colors.grey,
                              decoration: InputDecoration.collapsed(
                                hintText: "Title",
                              ),
                              style: noteTextStyle,
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Note:",
                              style: noteTitleStyle,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextField(
                              cursorColor: Colors.grey,
//                  controller: _textController,
                              decoration: InputDecoration.collapsed(
                                hintText: "Note",
                              ),
                              style: noteTextStyle,
                              keyboardType: TextInputType.multiline,
                              maxLines: 20,
                            ),
                            SizedBox(height: 20.0),
                            Align(
                              alignment: Alignment.bottomRight,
                                child: NoteButton("Add", Colors.green, (){}))
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
