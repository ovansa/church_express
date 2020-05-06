import 'dart:convert';

import 'package:church_express/models/LiveVideo.dart';
import 'package:church_express/models/LiveVids.dart';
import 'package:church_express/models/channel_model.dart';
import 'package:church_express/models/video_model.dart';
import 'package:church_express/screens/video_screens.dart';
import 'package:church_express/services/api_service.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LiveStream2 extends StatefulWidget {
  @override
  _LiveStream2State createState() => _LiveStream2State();
}

class _LiveStream2State extends State<LiveStream2> {
  Channel _channel;
  bool _isLoading = false;
  List<LiveVideo> _liveVideos;

  Future<LiveVids> theVideos;

  int _noOfVids;

  @override
  void initState() {
    super.initState();
    _initChannel();

//    fetchLiveVideos();

    theVideos = fetchTheVids();
    theVideos.then((val){
      _noOfVids = val.items.length;
      print(_noOfVids);
      print(val.items[0].id.videoId);
      print(val.items[0].snippet.channelTitle);
    });
  }

  Future<LiveVids> fetchTheVids() async {
    http.Response response = await http.get(
        'https://www.googleapis.com/youtube/v3/search?key=AIzaSyCFWKRQli9kGclT16QmfdTajZnSdEgoys8&channelId=UCNye-wNBqNL5ZzHSJj3l8Bg&part=snippet,id&eventType=live&type=video');

    if (response.statusCode == 200) {
      print(response.toString());
      return LiveVids.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting vids");
    }
  }

  fetchLiveVideos() async {
    List<LiveVideo> videos = await APIService.instance.fetchLiveVideos(channelId: "UCeY0bbntWzzVIaj2z3QigXg");
    print(videos[0].id);

    setState(() {
      _liveVideos = videos;
      _noOfVids = videos.length;
    });
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCeY0bbntWzzVIaj2z3QigXg');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
//            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        padding: EdgeInsets.all(10.0),
        height: 90.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
              child: Image(
                width: 70.0,
                height: 55.0,
                image: NetworkImage(video.thumbnailUrl),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 3.0,),
                    Text(
                      video.title,
                      style: videoTitleStyle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                    SizedBox(height: 3,),
                    Text(
                      video.description,
                      style: videoDescriptionStyle,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                    ),
                    SizedBox(height: 3,),
                    Text(
                      video.publishedAt.split("T")[0],
                      style: videoDateStyle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _buildLiveVideo(Items items) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: items.id.videoId),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              blurRadius: 1.0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                width: 70.0,
                height: 55.0,
                image: NetworkImage(items.snippet.thumbnails.defaults.url),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 3.0,),
                  Text(
                      items.snippet.title,
                      style: videoTitleStyle,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  SizedBox(height: 3,),
                  Text(
                      items.snippet.description,
                      style: videoDescriptionStyle,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                  ),
                  SizedBox(height: 3,),
                  Text(
                    items.snippet.publishedAt.split("T")[0],
                    style: videoDateStyle,
                  ),
                ],
              ),
            ),
            CircleAvatar(backgroundColor: Colors.red, radius: 4.0,),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          "Videos",
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
      body: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/banner.png",
                    ),
                    fit: BoxFit.fill,
                  ))),
          _noOfVids == 0 ? SizedBox.shrink() :
          FutureBuilder(
              future: theVideos,
              builder: (BuildContext context, AsyncSnapshot<LiveVids> snapshot) {
                if(snapshot.hasData) {
                  return Expanded(
                    flex: 1,
                    child: Container(
                      height: 70.0,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (context, index) {
                            Items item = snapshot.data.items[index];
                            return _buildLiveVideo(item);
                          }),
                    ),
                  );
                } else {
                  return Container(height: 0.0, width: 0.0,);
                }
              }),
//          Expanded(
//            flex: 1,
//            child: Container(
//              height: 70,
//              child: FutureBuilder(
//                  future: theVideos,
//                  builder: (BuildContext context, AsyncSnapshot<LiveVids> snapshot) {
//                    if(snapshot.hasData) {
//                      return ListView.builder(
//                          physics: BouncingScrollPhysics(),
//                          itemCount: snapshot.data.items.length,
//                          itemBuilder: (context, index) {
//                            Items item = snapshot.data.items[index];
//                            return _buildLiveVideo(item);
//                          });
//                    } else {
//                      return SizedBox.shrink();
//                    }
//                  }),
//            ),
//          ),
          _channel != null ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  print(_channel.videos[0].channelTitle);
                  _loadMoreVideos();
                }
                return false;
              }, child: Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 1 + _channel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return SizedBox.shrink();
                  }
                  Video video = _channel.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            ),
          )
          ) : Expanded(
            flex: 8,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  appBarColor, // Red
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}