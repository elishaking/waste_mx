import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './payment_confirmed.dart';

class WalletPayPage extends StatelessWidget{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${transactionFee.toString()} NGN transaction fee'),
                      SizedBox(height: 5,),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_balance_wallet),
                          labelText: 'amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        validator: (String value){
                          if(value.isEmpty) return 'Please enter amount';
                        },
                        onSaved: (String value){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => PaymentConfirmedPage(double.parse(value))
                          ));
                        },
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
                           if(_formKey.currentState.validate()){
                             _formKey.currentState.save();
                           }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}