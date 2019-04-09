import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './credit_wallet.dart';
import './wallet_pay.dart';

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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => CreditWalletPage()
                      ));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30,),
              RaisedButton(
                child: customText.BodyText(text: 'Make Payment', textColor: Colors.white,),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WalletPayPage()
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}