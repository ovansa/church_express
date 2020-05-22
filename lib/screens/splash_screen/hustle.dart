import 'package:church_express/screens/authentication/login.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:flutter/material.dart';

class Hustle extends StatefulWidget {
  @override
  _HustleState createState() => _HustleState();
}

class _HustleState extends State<Hustle> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _name;

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
//                                Expanded(
//                                  child: FlatButton(
//                                    onPressed: _loading ? null : _startHandlingButton,
//                                    padding: EdgeInsets.symmetric(vertical: 17.0),
//                                    color: floatButtonColor,
//                                    child: setupButtonChild(),
//                                    shape: RoundedRectangleBorder(
//                                      borderRadius: new BorderRadius.circular(18.0),
//                                    ),
//                                  ),
//                                )
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
}
