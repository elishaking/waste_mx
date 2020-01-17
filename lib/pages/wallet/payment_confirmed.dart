import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart' as customText;

import './transactions.dart';

class PaymentConfirmedPage extends StatelessWidget {
  final double amount;

  PaymentConfirmedPage(this.amount);

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Confirmed"),
      ),
      body: Center(
        child: Container(
            padding:
                EdgeInsets.symmetric(vertical: 18, horizontal: _getSize(18)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/wallet.png'),
                  height: _getSize(100),
                ),
                SizedBox(
                  height: _getSize(25),
                ),
                Container(
                  padding: EdgeInsets.all(_getSize(10)),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(100)),
                  child: customText.BodyText(
                    text:
                        '${amount.toString()} NGN has been debited from your wallet. Your money is safe in',
                    textColor: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,
                    textOverflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: _getSize(25),
                ),
                Text('Wallet Balance'),
                SizedBox(
                  height: _getSize(15),
                ),
                customText.HeadlineText(
                  text: 'N 5,000',
                  textColor: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: _getSize(25),
                ),
                RaisedButton(
                  child: customText.BodyText(
                      text: 'Track Payments', textColor: Colors.white),
                  onPressed: () {
                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         TransactionsPage()));
                  },
                )
              ],
            )),
      ),
    );
  }
}
