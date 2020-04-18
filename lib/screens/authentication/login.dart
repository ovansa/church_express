import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:church_express/screens/authentication/preferences.dart';
import 'package:church_express/screens/authentication/sign_up.dart';
import 'package:church_express/screens/authentication/user_model.dart';
import 'package:church_express/screens/welcome.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:progress_hud/progress_hud.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserModel userModel;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String _email;
  String _password;

  @override
  void initState() {
    super.initState();
  }

  ProgressDialog si;

  @override
  Widget build(BuildContext context) {
    si = ProgressDialog(context,
        showLogs: true, isDismissible: false);
    si.style(
      message: "Logging in ...",
      elevation: 10.0,
      messageTextStyle: videoTitleStyle,
      insetAnimCurve: Curves.easeInOut,
    );

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Login",
                  style: welcomeTitle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Enter your details to login",
                  style: welcomeSubTitle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Form(
                  key: formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(
                        title: TextFormField(
                          style: welcomeTextField,
                          decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: welcomeTextField,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8),
                                    width: 1.5),
                              ),
                              labelText: 'Email',
                              labelStyle: welcomeTextField),
                          initialValue: "",
                          onSaved: (val) => _email = val,
                          validator: (val) =>
                              val == "" ? "Email is required" : null,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      ListTile(
                        title: TextFormField(
                          style: welcomeTextField,
                          decoration: InputDecoration(
                              hintText: "*******",
                              hintStyle: welcomeTextField,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8),
                                    width: 1.5),
                              ),
                              labelText: 'Password',
                              labelStyle: welcomeTextField),
                          obscureText: true,
                          initialValue: "",
                          onSaved: (val) => _password = val,
                          validator: (val) =>
                              val == "" ? "Password is required" : null,
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  _handleSubmit();
                                },
                                padding: EdgeInsets.symmetric(vertical: 17.0),
                                color: floatButtonColor,
                                child: Text(
                                  "Submit",
                                  style: welcomeSubmitButton,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      GestureDetector(
                        onTap: () {
//                          Navigator.pushReplacement(
//                              context,
//                              PageRouteBuilder(
//                                  pageBuilder: (BuildContext context, _, __) => Welcome(),
//                                  transitionsBuilder:
//                                      (_, Animation<double> animation, __, Widget child) {
//                                    return new FadeTransition(opacity: animation, child: child);
//                                  }));
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (BuildContext context, _, __) =>
                                      SignUp(),
                                  transitionsBuilder: (_,
                                      Animation<double> animation,
                                      __,
                                      Widget child) {
                                    return new FadeTransition(
                                        opacity: animation, child: child);
                                  }));
                        },
                        child: Text("New? Register"),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _handleSubmit() async {
    final FormState formState = formKey.currentState;
    si.show();
    if (formState.validate()) {
      formState.save();
      try {
        FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        print("Logged in");
        si.hide().whenComplete(() {
          setLoggedInPreference(true).then((bool committed) {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (BuildContext context, _, __) => Welcome(),
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return new FadeTransition(opacity: animation, child: child);
                    }));
          });
        });
      } catch (error) {
        si.hide().whenComplete(() {
          if (error.code == 'ERROR_USER_NOT_FOUND') {
            print('ERROR_USER_NOT_FOUND');
            final snackBar = SnackBar(
              content: Text('Oops! Wrong email or password'),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {
                },
              ),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);
          } else if (error.code == 'ERROR_WRONG_PASSWORD') {
            print('ERROR_WRONG_PASSWORD');
            final snackBar = SnackBar(
              content: Text('Oops! Weak Password'),
              action: SnackBarAction(
                label: 'Cancel',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);
          } else {
          }
        });
      }
    }
  }
}
