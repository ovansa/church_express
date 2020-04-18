//import 'package:church_express/utils/text_styles.dart';
//import 'package:flutter/material.dart';
//import 'package:progress_dialog/progress_dialog.dart';
//
//class ProgInd extends StatefulWidget {
//  @override
//  _ProgIndState createState() => _ProgIndState();
//}
//
//class _ProgIndState extends State<ProgInd> {
//  ProgressDialog pr;
//
//  @override
//  Widget build(BuildContext context) {
//    pr = new ProgressDialog(context,
//        showLogs: true,);
//    pr.style(
//      message: 'Signing In...',
//      elevation: 10.0,
//      messageTextStyle: videoTitleStyle,
//      insetAnimCurve: Curves.easeInOut,
//    );
//
//    return Scaffold(
//        body: Center(
//      child: FlatButton(
//          onPressed: () {
//            pr.show();
//          },
//          child: Text("Show")),
//    ));
//  }
//}
