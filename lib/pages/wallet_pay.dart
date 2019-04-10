import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './payment_confirmed.dart';

class WalletPayPage extends StatelessWidget{
  final double walletBalance = 5000;
  final double transactionFee = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pay with Wallet'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Wallet Balance'),
                customText.HeadlineText(text: 'N ${walletBalance.toString()}', textColor: Theme.of(context).primaryColor,),
                SizedBox(height: 25,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text('${transactionFee.toString()} NGN transaction fee'),
                ),
                SizedBox(height: 5,),
                TextFormField(
                  enabled: false,
                  initialValue: '1000',
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_wallet),
                    labelText: 'amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Center(child: FlatButton(
                  child: Text('Payment Terms'),
                  onPressed: (){
                    
                  },
                ),),
                SizedBox(height: 20,),
                Center(
                  child: RaisedButton(
                    child: customText.BodyText(text: 'Pay Securely', textColor: Colors.white,),
                    onPressed: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => PaymentConfirmedPage(1000)
                      ));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}