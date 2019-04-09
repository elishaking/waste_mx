import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class WalletPage extends StatelessWidget{
  final double walletBalance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                width: 200,
                image: AssetImage('assets/wallet-enclosed.png'),
              ),
              customText.TitleText(
                text: 'Waste MX Wallet Balance',
                textColor: Theme.of(context).primaryColor,
              ),
              customText.BodyText(
                text: walletBalance.toString(),
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('View Statement'),
                    onPressed: (){

                    },
                  ),
                  OutlineButton(
                    child: Text('Credit Wallet'),
                    onPressed: (){

                    },
                  ),
                ],
              ),
              SizedBox(height: 30,),
              RaisedButton(
                child: Text('Make Payment'),
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