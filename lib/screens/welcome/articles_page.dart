import 'package:church_express/screens/welcome/events/article.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Freedom",
          style: appBarTextStyle,
        ),
        backgroundColor: appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Text("How to Make this Moment the Turning Point for Real Change", style: articleHeaderStyle,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/sims.png"),
                    radius: 10.0,
                  ),
                  SizedBox(width: 10.0,),
                  Text("5 days ago", style: articleSubTextStyle,),
                  SizedBox(width: 6.0,),
                  CircleAvatar(backgroundColor: Colors.grey, radius: 2.0,),
                  SizedBox(width: 6.0,),
                  Text("4 min read", style: articleSubTextStyle,)
                ],
              ),
            ),
            SizedBox(height: 10.0,),
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/banner.png"), fit: BoxFit.cover)
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Photo by Xena Goldman", style: articlePhotoByStyle,)
              ],
            ),
            SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(text, style: articleTextStyle),
            ),
          ],
        ),
      ),
    );
  }
}
