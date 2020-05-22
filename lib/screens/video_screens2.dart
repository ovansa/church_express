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
          leading: IconButton(
              icon: Image.asset("assets/icons/drawer_icon.png"),
              onPressed: () {
                _globalKey.currentState.openDrawer();
              })),
      drawer: AppDrawer(),
      body: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child:  YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                onReady: () {
                  print('Player is ready.');
                },
              ),
            ),
            Expanded(child: Container(
              child: Center(
                child: Text("The Note Space"),
              ),
            ))
          ],
        ),
      ),
    );
  }
}