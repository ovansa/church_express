import 'dart:convert';

import 'package:church_express/screens/bible/bib/bible_model.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';

class VersePage extends StatefulWidget {
  final String chapter;
  final String book_name;
  final int index;

  const VersePage({Key key, this.chapter, this.book_name, this.index}) : super(key: key);

  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  Future<BibleModel> loadChapters() async {
    String bookString = await DefaultAssetBundle.of(context).loadString("assets/bible/${widget.book_name.toString()}.json");
    var jsonR = json.decode(bookString);
    return BibleModel.fromJson(jsonR);
  }

  Future<BibleModel> chapter;

  @override
  void initState() {
    chapter = loadChapters();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book_name + " " + widget.chapter,
          style: appBarTextStyle,
        ),
        backgroundColor: appBarColor,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: FutureBuilder(
              future: chapter,
              builder: (BuildContext context, AsyncSnapshot<BibleModel> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data.chapters[widget.index].verses.length,
                      itemBuilder: (context, index) {
                    String verse = snapshot.data.chapters[widget.index].verses[index].text.toString();
                    String verse_no = snapshot.data.chapters[widget.index].verses[index].verse.toString();
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(verse_no, style: bibleContentStyle),
                            SizedBox(width: 5.0,),
                            Flexible(child: Text(verse, style: bibleContentStyle))
                          ],
                        ),
                      ),
                    );
                  });
                } else {
                  return Center(
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(appBarColor),),
                  );
                }
              }),
        ),
      ),
    );
  }
}
