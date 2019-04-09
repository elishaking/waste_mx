import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class CreditWalletPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credit Wallet'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Add money to wallet',),
              SizedBox(height: 15,),
              Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.account_balance_wallet),
                        labelText: 'amount',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    RaisedButton(
                      child: customText.BodyText(
                        text: 'Proceed',
                        textColor: Colors.white,
                      ),
                      onPressed: (){

                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 25,),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.info_outline),
                    SizedBox(width: 10,),
                    Text('Why use Waste MX Wallet')
                  ],
                ),
                onPressed: (){

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}