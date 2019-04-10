import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class PaymentConfirmedPage extends StatelessWidget{
  final double amount;

  PaymentConfirmedPage(this.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Confirmed"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Wallet Balance'),
              customText.HeadlineText(text: 'N 5,000', textColor: Theme.of(context).primaryColor,),
              SizedBox(height: 25,),
              customText.BodyText(
                text: '${amount.toString()} NGN has been debited from your wallet. Your money is safe in',
              )
            ],
          )
        ),
      ),
    );
  }
}