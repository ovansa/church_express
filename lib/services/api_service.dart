import 'dart:convert';
import 'dart:io';

import 'package:church_express/models/LiveVideo.dart';
import 'package:church_express/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:church_express/models/channel_model.dart';
import 'package:church_express/utils/keys.dart';

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // Get Channel
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // Fetch first batch of videos from uploads playlist
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<LiveVideo>> fetchLiveVideos({String channelId}) async {
    Map<String, String> parameters = {
      'key': 'AIzaSyCFWKRQli9kGclT16QmfdTajZnSdEgoys8',
      'id': 'UCeY0bbntWzzVIaj2z3QigXg',
      'part': 'snippet, id',
      'eventType': 'live',
      'type': 'video'
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/search',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      List<dynamic> videoJson = data['items'];
      print(videoJson.toString());

      List<LiveVideo> videos = [];
      videoJson.forEach(
              (json) => videos.add(
                  LiveVideo.fromMap(json)));
      print(videos);
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    
    Uri ri = Uri.https("www.googleapis.com",
        "youtube/v3/search?key=AIzaSyCFWKRQli9kGclT16QmfdTajZnSdEgoys8&channelId=UCeY0bbntWzzVIaj2z3QigXg&part=snippet,id&eventType=live&type=video");

    // Get Playlist Videos
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // Fetch first eight videos from uploads playlist
      List<Video> videos = [];
      videosJson.forEach(
        (json) => videos.add(
          Video.fromMap(json['snippet']),
        ),
      );
      return videos;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
