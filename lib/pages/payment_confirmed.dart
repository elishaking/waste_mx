import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './track_transactions.dart';

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
                textColor: Colors.black,
                textAlign: TextAlign.center,
                textOverflow: TextOverflow.clip,
              ),
              SizedBox(height: 25,),
              RaisedButton(
                child: customText.BodyText(text: 'Track Payments', textColor: Colors.white),
                onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => TrackTransactionsPage()
                  ));
                },
              )
            ],
          )
        ),
      ),
    );
  }
}