import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class WalletPayPage extends StatelessWidget{
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
                customText.TitleText(text: 'N 5,000', textColor: Theme.of(context).primaryColor,),
                SizedBox(height: 25,),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('50 NGN transaction fee'),
                      SizedBox(height: 5,),
                      TextFormField(
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