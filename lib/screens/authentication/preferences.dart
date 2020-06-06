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

Future<bool> setEmailPreference (String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("_email", email);
  return prefs.commit();
}

Future<String> getEmailPreference () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString("_email");
  return email;
}