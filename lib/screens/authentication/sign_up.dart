import 'package:church_express/screens/authentication/login.dart';
import 'package:church_express/screens/authentication/preferences.dart';
import 'package:church_express/screens/authentication/user_model.dart';
import 'package:church_express/screens/welcome/welcome.dart';
import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel userModel;

  final FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  DatabaseReference databaseReference;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String _email;
  String _password;
  String _name;

  int _state = 0;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
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
                        "Welcome",
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
                          "Kindly fill out the form below to register",
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                      key: formKey,
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          ListTile(
                            title: TextFormField(
                              style: welcomeTextField,
                              decoration: InputDecoration(
                                  hintText: "Full Name",
                                  hintStyle: welcomeTextField,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15.0)),
                                    borderSide: BorderSide(
                                        color: Colors.black.withOpacity(0.8),
                                        width: 1.5),
                                  ),
                                  labelText: 'Full Name',
                                  labelStyle: welcomeTextField),
                              initialValue: "",
                              onSaved: (val) => _name = val,
                              validator: (val) =>
                                  val == "" ? "Name is required" : null,
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
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
                                    onPressed: _loading ? null : _startHandlingButton,
                                    padding: EdgeInsets.symmetric(vertical: 17.0),
                                    color: floatButtonColor,
                                    child: setupButtonChild(),
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
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (BuildContext context, _, __) =>
                                          Login(),
                                      transitionsBuilder: (_,
                                          Animation<double> animation,
                                          __,
                                          Widget child) {
                                        return new FadeTransition(
                                            opacity: animation, child: child);
                                      }));
                            },
                            child: Text("Have Account? Login", style: welcomeNewTitle,),
                          )
                        ],
                      )),
                )
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

  _handleSubmit() async {
    final FormState formState = formKey.currentState;
    if (formState.validate()) {
      setState(() {
        _state = 1;
      });
      formState.save();
      firebaseAuth.createUserWithEmailAndPassword(email: _email, password: _password).then((result){
        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
        userUpdateInfo.displayName = _name;
        FirebaseUser user = result.user;

        setEmailPreference(_email);
        setState(() {
          _state = 2;
        });
        setLoggedInPreference(true).then((bool committed) {
          user.updateProfile(userUpdateInfo).then((onValue) {
            print("Signed up and logged in");
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
        scaffoldKey.currentState.showSnackBar(snackBar);
      });
    }
//      try {
//        FirebaseUser user = (await firebaseAuth.createUserWithEmailAndPassword(
//                email: _email, password: _password))
//            .user;
//        UserUpdateInfo userUpdateInfo = UserUpdateInfo();
//        userUpdateInfo.displayName = _name;
//        su.hide();
//        setLoggedInPreference(true).then((bool committed){
//          user.updateProfile(userUpdateInfo).then((onValue) async {
//            print("Signed Up and Logged in");
//            su.hide().whenComplete(() {
//              Navigator.pushReplacement(
//                  context,
//                  PageRouteBuilder(
//                      pageBuilder: (BuildContext context, _, __) => Welcome(),
//                      transitionsBuilder:
//                          (_, Animation<double> animation, __, Widget child) {
//                        return new FadeTransition(opacity: animation, child: child);
//                      }));
//            });
//          });
//        });
//      } catch (error) {
//        su.hide().whenComplete(() {
//          if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//            print('ERROR_EMAIL_ALREADY_IN_USE');
//            final snackBar = SnackBar(
//              content: Text('Oops! Email already in use.'),
//              action: SnackBarAction(
//                label: 'Cancel',
//                onPressed: () {
//                  // Some code to undo the change.
//                },
//              ),
//            );
//            scaffoldKey.currentState.showSnackBar(snackBar);
//          } else if (error.code == 'ERROR_WEAK_PASSWORD') {
//            print('ERROR_WEAK_PASSWORD');
//            final snackBar = SnackBar(
//              content: Text('Oops! Weak Password'),
//              action: SnackBarAction(
//                label: 'Cancel',
//                onPressed: () {
//                  // Some code to undo the change.
//                },
//              ),
//            );
//            scaffoldKey.currentState.showSnackBar(snackBar);
//          } else {}
//        });
//      }
//    }
  }
}
