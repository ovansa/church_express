import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'chapter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:html/dom.dart' as dom;

class ChapterPage extends StatefulWidget {
  final String id;
  final String reference;

  const ChapterPage({Key key, this.id, this.reference}) : super(key: key);

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  Future<Chapter> fetchChapter() async {
    http.Response response = await http.get(
        'https://api.scripture.api.bible/v1/bibles/de4e12af7f28f599-02/chapters/${widget.id}',
        headers: {'api-key': 'dad5f80c56fea90e6a36e481cf1c4ddd'});

    if (response.statusCode == 200) {
      return Chapter.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting books");
    }
  }

  Future<Chapter> theChapter;

  @override
  void initState() {
    theChapter = fetchChapter();
    theChapter.then((val) {
      print(val.data.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(child: FutureBuilder(
            future: theChapter,
            builder: (BuildContext context, AsyncSnapshot<Chapter> snapshot) {
              if(snapshot.hasData) {
                return Html(data: snapshot.data.data.content,
                  customRender: (node, children) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "custom_tag":
                          return Column(children: children);
                      }
                    }
                    return null;
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
      ),
    );
  }
}
