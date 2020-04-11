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
  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: publicKey);
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldlKey = new GlobalKey();
    final _formKey = GlobalKey<FormState>();

    String _cardNumber;
    String _cvv;
    int _expiryMonth = 0;
    int _expiryYear = 0;
    int _amountToDonate = 0;

    bool _inProgress = false;

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
      _formKey.currentState.save();
      Charge charge = Charge()
        ..amount = 10000 // In base currency
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
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        labelText: 'Amount',
                        labelStyle: TextStyle(fontSize: 16.0)
                      ),
                      onSaved: (String value) => _amountToDonate = int.tryParse(value),
                    ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: <Widget>[
                        Expanded(child: RaisedButton(
                          onPressed: (){
                            print("Paystack Card UI");
                            _handleCheckout(context);
                          },
                          color: Color(0xFFFFDA1A),
                          textColor: Color(0xFF000000),
                          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                          child: Text("Paystack Card UI",
                            style: GoogleFonts.montserrat(fontSize: 17.0),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
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

