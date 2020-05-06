import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

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
        'https://api.scripture.api.bible/v1/bibles/de4e12af7f28f599-02/chapters/${widget.id}?content-type=text',
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
      appBar: AppBar(
          title: Text(
            "Bible - King James Version",
            style: appBarTextStyle,
          ),
          backgroundColor: appBarColor,
          ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(widget.reference, style: bibleChapterStyle,),
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: FutureBuilder(
                  future: theChapter,
                  builder: (BuildContext context, AsyncSnapshot<Chapter> snapshot) {
                    if(snapshot.hasData) {
                      String newData = snapshot.data.data.content.replaceAll("span", "p");
                      print(newData);
                      return Text(
                        newData, style: bibleContentStyle,
                      );
//                      return Html(data: snapshot.data.data.content,
//                        useRichText: true,
//                        defaultTextStyle: bibleContentStyle,
//                        renderNewlines: true,
//                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(appBarColor),),
                      );
                    }
                  }),
            )
          ],
        ),
      ))
    );
  }
}
