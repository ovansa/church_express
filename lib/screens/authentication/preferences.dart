import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setLoggedInPreference (bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("_isLoggedIn", isLoggedIn);
  return prefs.commit();
}

Future<bool> getLoggedInPreference () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool("_isLoggedIn");
  return isLoggedIn;
}

ProgressDialog showProgress(BuildContext context, String message) {
  ProgressDialog rp;
  rp = new ProgressDialog(context,
      showLogs: true, isDismissible: false);
  rp.style(
    message: message,
    elevation: 10.0,
    messageTextStyle: videoTitleStyle,
    insetAnimCurve: Curves.easeInOut,
  );
  return rp;
}