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

  bool _isLoading;

  int _state = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      _state = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Color(0xFFf8ed62).withOpacity(0.1),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Opacity(
                        opacity: 0.9,
                        child: Image.asset("assets/church_logo.png", height: 100.0,)),
                  ],
                ),
                SizedBox(height: 20.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Login",
                        style: welcomeTitle,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Enter your details to login",
                          style: welcomeSubTitle,
                        ),
                      ),
                    ),
                  ],
                ),


                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
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
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Color(0xFF262F3A)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF262F3A).withOpacity(0.8),
                                        width: 1.5),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: welcomeTextField),
                              initialValue: "",
                              onSaved: (val) => _email = val.trim(),
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
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Color(0xFF262F3A)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF262F3A).withOpacity(0.8),
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
                                    onPressed: _loading ? null : _startHandlingButton,
                                    padding:
                                    EdgeInsets.symmetric(vertical: 17.0),
                                    color: floatButtonColor,
                                    child: setupButtonChild(),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(18.0),
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
                            child: Text("New? Register", style: welcomeNewTitle,),
                          ),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _loading = false;

  setLoading(bool state) {
    setState(() {
      _loading = state;
    });
  }

  _startHandlingButton() async {
    try {
      setLoading(true);
      print("button disabled");
      await _handleSubmit();
    } finally {
      setLoading(false);
      print("button enabled");
    }
  }

  setupButtonChild() {
    if (_state == 0) {
      return Text("Submit", style: welcomeSubmitButton,);
    } else if (_state == 1){
      return SizedBox(
        height: 20.0,
        width: 20.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  _handleSubmit() async {
    final FormState formState = formKey.currentState;

    if (formState.validate()) {
      setState(() {
        _state = 1;
      });
      formState.save();
      print("Valid");
      firebaseAuth.signInWithEmailAndPassword(email: _email, password: _password).then((result){
        print("It worked!");
        setEmailPreference(_email);
        setState(() {
          _state = 2;
        });
        setLoggedInPreference(true).then((bool committed) {
          Navigator.pop(context);
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (BuildContext context, _, __) => Welcome(),
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return new FadeTransition(opacity: animation, child: child);
                  }));
        });
      }).catchError((error){
        setState(() {
          _state = 0;
        });
        print(error.message);
        final snackBar = SnackBar(
            content: Text(error.message),
            action: SnackBarAction(
              label: 'Cancel',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          _scaffoldKey.currentState.showSnackBar(snackBar);
      });
//      try {
//        FirebaseUser user = (await firebaseAuth.signInWithEmailAndPassword(
//                email: _email, password: _password))
//            .user;
//        print("Logged in");
//        setLoggedInPreference(true).then((bool committed) {
//          Navigator.pushReplacement(
//              context,
//              PageRouteBuilder(
//                  pageBuilder: (BuildContext context, _, __) => Welcome(),
//                  transitionsBuilder:
//                      (_, Animation<double> animation, __, Widget child) {
//                    return new FadeTransition(opacity: animation, child: child);
//                  }));
//        });
//      } catch (error) {
//        if (error.code == 'ERROR_USER_NOT_FOUND') {
//          print('ERROR_USER_NOT_FOUND');
//          final snackBar = SnackBar(
//            content: Text('Oops! Wrong email or password'),
//            action: SnackBarAction(
//              label: 'Cancel',
//              onPressed: () {},
//            ),
//          );
//          _scaffoldKey.currentState.showSnackBar(snackBar);
//        } else if (error.code == 'ERROR_WRONG_PASSWORD') {
//          print('ERROR_WRONG_PASSWORD');
//          final snackBar = SnackBar(
//            content: Text('Oops! Weak Password'),
//            action: SnackBarAction(
//              label: 'Cancel',
//              onPressed: () {
//                // Some code to undo the change.
//              },
//            ),
//          );
//          _scaffoldKey.currentState.showSnackBar(snackBar);
//        } else {}
//      }
    }
  }
}
