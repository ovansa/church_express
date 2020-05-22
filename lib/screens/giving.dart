import 'dart:io';

import 'package:church_express/screens/welcome.dart';
import 'package:church_express/widgets/drawer_widgets/app_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class Giving extends StatefulWidget {

  @override
  _GivingState createState() => _GivingState();
}

class _GivingState extends State<Giving> {
  var publicKey = 'pk_test_b80c8aeef509570aaf0654e8e768d1a3ec0e605c';
  @override
  void initState() {
    PaystackPlugin.initialize(publicKey: publicKey);
  }

  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _verticalSizeBox = const SizedBox(height: 20.0);
  final _horizontalSizeBox = const SizedBox(width: 10.0);
  var _border = new Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.red,
  );
  int _radioValue = 0;
  CheckoutMethod _method;
  bool _inProgress = false;
  String _cardNumber;
  String _cvv;
  int _expiryMonth = 0;
  int _expiryYear = 0;
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(title: Text("Pay")),
        body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Form(
            key: _formKey,
            child: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Expanded(
                        child: const Text('Initalize transaction from:'),
                      ),
                      new Expanded(
                        child: new Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new RadioListTile<int>(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChanged,
                                title: const Text('Local'),
                              ),
                              new RadioListTile<int>(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChanged,
                                title: const Text('Server'),
                              ),
                            ]),
                      )
                    ],
                  ),
                  _border,
                  _verticalSizeBox,
                  new TextFormField(
                    decoration: const InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: 'Card number',
                    ),
                    onSaved: (String value) => _cardNumber = value,
                  ),
                  _verticalSizeBox,
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'CVV',
                          ),
                          onSaved: (String value) => _cvv = value,
                        ),
                      ),
                      _horizontalSizeBox,
                      new Expanded(
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Expiry Month',
                          ),
                          onSaved: (String value) =>
                          _expiryMonth = int.tryParse(value),
                        ),
                      ),
                      _horizontalSizeBox,
                      new Expanded(
                        child: new TextFormField(
                          decoration: const InputDecoration(
                            border: const UnderlineInputBorder(),
                            labelText: 'Expiry Year',
                          ),
                          onSaved: (String value) =>
                          _expiryYear = int.tryParse(value),
                        ),
                      )
                    ],
                  ),
                  _verticalSizeBox,
                  Theme(
                    data: Theme.of(context).copyWith(
                      accentColor: green,
                      primaryColorLight: Colors.white,
                      primaryColorDark: navyBlue,
                      textTheme: Theme.of(context).textTheme.copyWith(
                        body2: TextStyle(
                          color: lightBlue,
                        ),
                      ),
                    ),
                    child: Builder(
                      builder: (context) {
                        return _inProgress
                            ? new Container(
                          alignment: Alignment.center,
                          height: 50.0,
                          child: Platform.isIOS
                              ? new CupertinoActivityIndicator()
                              : new CircularProgressIndicator(),
                        )
                            : new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _getPlatformButton(
                                'Charge Card', () => _startAfreshCharge()),
                            _verticalSizeBox,
                            _border,
                            new SizedBox(
                              height: 40.0,
                            ),
                            new Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Flexible(
                                  flex: 3,
                                  child: new DropdownButtonHideUnderline(
                                    child: new InputDecorator(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        isDense: true,
                                        hintText: 'Checkout method',
                                      ),
                                      isEmpty: _method == null,
                                      child: new DropdownButton<
                                          CheckoutMethod>(
                                        value: _method,
                                        isDense: true,
                                        onChanged: (CheckoutMethod value) {
                                          setState(() {
                                            _method = value;
                                          });
                                        },
                                        items: banks.map((String value) {
                                          return new DropdownMenuItem<
                                              CheckoutMethod>(
                                            value:
                                            _parseStringToMethod(value),
                                            child: new Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                _horizontalSizeBox,
                                new Flexible(
                                  flex: 2,
                                  child: new Container(
                                    width: double.infinity,
                                    child: _getPlatformButton(
                                      'Checkout',
                                          () => _handleCheckout(context),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    return  Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (BuildContext context, _, __) => Welcome(),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return new FadeTransition(
                  opacity: animation, child: child);
            }));
  }
  void _handleRadioValueChanged(int value) =>
      setState(() => _radioValue = value);

  _handleCheckout(BuildContext context) async   {
    if (_method == null) {
      _showMessage('Select checkout method first');
      return;
    }

    if (_method != CheckoutMethod.card && _isLocal) {
      _showMessage('Select server initialization method at the top');
      return;
    }
    setState(() => _inProgress = true);
    _formKey.currentState.save();
    Charge charge = Charge()
      ..amount = 10000 // In base currency
      ..email = 'customer@email.com'
      ..card = _getCardFromUI();

    if (!_isLocal) {
//      var accessCode = await _fetchAccessCodeFrmServer(_getReference());
//      charge.accessCode = accessCode;
    print("Not local");
    } else {
      charge.reference = _getReference();
    }

    try {
      CheckoutResponse response = await PaystackPlugin.checkout(
        context,
        method: _method,
        charge: charge,
        fullscreen: false,
        logo: MyLogo(),
      );
      print('Response = $response');
      setState(() => _inProgress = false);
      _updateStatus(response.reference, '$response');
    } catch (e) {
      setState(() => _inProgress = false);
      _showMessage("Check console for error");
      rethrow;
    }
  }

  _startAfreshCharge() async {
    _formKey.currentState.save();

    Charge charge = Charge();
    charge.card = _getCardFromUI();

    setState(() => _inProgress = true);

    if (_isLocal) {
      // Set transaction params directly in app (note that these params
      // are only used if an access_code is not set. In debug mode,
      // setting them after setting an access code would throw an exception

      charge
        ..amount = 10000 // In base currency
        ..email = 'customer@email.com'
        ..reference = _getReference()
        ..putCustomField('Charged From', 'Flutter SDK');
      _chargeCard(charge);
    } else {
      // Perform transaction/initialize on Paystack server to get an access code
      // documentation: https://developers.paystack.co/reference#initialize-a-transaction
//      charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
//      _chargeCard(charge);

    }
  }

  _chargeCard(Charge charge) {
    // This is called only before requesting OTP
    // Save reference so you may send to server if error occurs with OTP
    handleBeforeValidate(Transaction transaction) {
      _updateStatus(transaction.reference, 'validating...');
    }

    handleOnError(Object e, Transaction transaction) {
      // If an access code has expired, simply ask your server for a new one
      // and restart the charge instead of displaying error
      if (e is ExpiredAccessCodeException) {
        _startAfreshCharge();
        _chargeCard(charge);
        return;
      }

      if (transaction.reference != null) {
//        _verifyOnServer(transaction.reference);
      } else {
        setState(() => _inProgress = false);
        _updateStatus(transaction.reference, e.toString());
      }
    }

    // This is called only after transaction is successful
    handleOnSuccess(Transaction transaction) {
//      _verifyOnServer(transaction.reference);
    }

    PaystackPlugin.chargeCard(context,
        charge: charge,
        beforeValidate: (transaction) => handleBeforeValidate(transaction),
        onSuccess: (transaction) => handleOnSuccess(transaction),
        onError: (error, transaction) => handleOnError(error, transaction));
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

  PaymentCard _getCardFromUI() {
    // Using just the must-required parameters.
    return PaymentCard(
      number: _cardNumber,
      cvc: _cvv,
      expiryMonth: _expiryMonth,
      expiryYear: _expiryYear,
    );
  }

  Widget _getPlatformButton(String string, Function() function) {
    // is still in progress
    Widget widget;
    if (Platform.isIOS) {
      widget = CupertinoButton(
        onPressed: function,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        color: CupertinoColors.activeBlue,
        child: new Text(
          string,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      );
    } else {
      widget = RaisedButton(
        onPressed: function,
        color: Colors.blueAccent,
        textColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 10.0),
        child: new Text(
          string.toUpperCase(),
          style: const TextStyle(fontSize: 17.0),
        ),
      );
    }
    return widget;
  }

//  Future<String> _fetchAccessCodeFrmServer(String reference) async {
//    String url = '$backendUrl/new-access-code';
//    String accessCode;
//    try {
//      print("Access code url = $url");
//      http.Response response = await http.get(url);
//      accessCode = response.body;
//      print('Response for access code = $accessCode');
//    } catch (e) {
//      setState(() => _inProgress = false);
//      _updateStatus(
//          reference,
//          'There was a problem getting a new access code form'
//              ' the backend: $e');
//    }
//
//    return accessCode;
//  }

//  void _verifyOnServer(String reference) async {
//    _updateStatus(reference, 'Verifying...');
//    String url = '$backendUrl/verify/$reference';
//    try {
//      http.Response response = await http.get(url);
//      var body = response.body;
//      _updateStatus(reference, body);
//    } catch (e) {
//      _updateStatus(
//          reference,
//          'There was a problem verifying %s on the backend: '
//              '$reference $e');
//    }
//    setState(() => _inProgress = false);
//  }

  _updateStatus(String reference, String message) {
    _showMessage('Reference: $reference \n\ Response: $message',
        const Duration(seconds: 7));
  }

  _showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(message),
      duration: duration,
      action: new SnackBarAction(
          label: 'CLOSE',
          onPressed: () => _scaffoldKey.currentState.removeCurrentSnackBar()),
    ));
  }

  bool get _isLocal => _radioValue == 0;

  var banks = ['Selectable', 'Bank', 'Card'];

  CheckoutMethod _parseStringToMethod(String string) {
    CheckoutMethod method = CheckoutMethod.selectable;
    switch (string) {
      case 'Bank':
        method = CheckoutMethod.bank;
        break;
      case 'Card':
        method = CheckoutMethod.card;
        break;
    }
    return method;
  }

}

class MyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: Text(
        "CO",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

const Color green = const Color(0xFF3db76d);
const Color lightBlue = const Color(0xFF34a5db);
const Color navyBlue = const Color(0xFF031b33);
