import 'dart:io';

import 'package:church_express/utils/colors.dart';
import 'package:church_express/utils/text_styles.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:google_fonts/google_fonts.dart';

class Give extends StatefulWidget {
  @override
  _GiveState createState() => _GiveState();
}

class _GiveState extends State<Give> {
  var publicKey = 'pk_test_b80c8aeef509570aaf0654e8e768d1a3ec0e605c';

  final GlobalKey<ScaffoldState> _scaffoldlKey = new GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  int _amountToDonate = 500000;
  String _email;

  bool _inProgress = false;

  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: publicKey);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldlKey,
      appBar: AppBar(
          title: Text(
            "Welcome",
            style: appBarTextStyle,
          ),
          backgroundColor: appBarColor,
          leading: IconButton(
              icon: Image.asset("assets/icons/drawer_icon.png"),
              onPressed: () {
                _scaffoldlKey.currentState.openDrawer();
              })),
      drawer: AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Give",
                  style: welcomeTitle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Give onto the lord",
                  style: welcomeSubTitle,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Form(
                  key: _formKey,
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      ListTile(

                        title: TextFormField(
                          style: welcomeTextField,
                          decoration: InputDecoration(
                              hintText: "Enter Amount",
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
                              labelText: 'Enter Amount',
                              labelStyle: welcomeTextField),
                          initialValue: "",
                          onSaved: (val) => _amountToDonate = int.tryParse(val) * 100,
                          validator: (val) =>
                          val == "" ? "Enter Amount" : null,
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: FlatButton(
                                onPressed: () {
                                  _handleCheckout(context);
                                },
                                padding: EdgeInsets.symmetric(vertical: 17.0),
                                color: floatButtonColor,
                                child: Text(
                                  "Give",
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
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }



  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  _showTheMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    print(message);
  }

  _updateStatus(String reference, String message) {
    _showTheMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

//    _showMessage(String message,
//        [Duration duration = const Duration(seconds: 4)]) {
//      _scaffoldKey.currentState.showSnackBar(new SnackBar(
//        content: new Text(message),
//        duration: duration,
//        action: new SnackBarAction(
//            label: 'CLOSE',
//            onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
//      ));
//    }
  _handleCheckout(BuildContext context) async   {
    final FormState formState = _formKey.currentState;
    print("Start validation");
    if (formState.validate()) {
      print("Validated");
      formState.save();
      Charge charge = Charge()
        ..amount = _amountToDonate // In base currency
        ..email = 'customer@email.com'
        ..card = _getCardFromUI();

      charge.reference = _getReference();

      try {
        CheckoutResponse response = await PaystackPlugin.checkout(
          context,
          method: CheckoutMethod.card,
          charge: charge,
          fullscreen: false,
          logo: MyLogo(),
        );
        print('Response = $response');
        setState(() => _inProgress = false);
        _updateStatus(response.reference, '$response');
      } catch (e) {
        setState(() => _inProgress = false);
        _showTheMessage("Check console for error");
//        _showMessage("Check console for error");
        rethrow;
      }
    }
  }
}
class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appBarColor,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "AT",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
