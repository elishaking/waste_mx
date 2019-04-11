import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './credit_wallet.dart';
import './wallet_pay.dart';

class WalletPage extends StatelessWidget{
  final bool payable;
  final double walletBalance = 5000.0;

  WalletPage(this.payable);

  double _targetWidth = 0;

  double _getSize(final double default_1440){
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

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
                width: _getSize(200),
                image: AssetImage('assets/wallet-enclosed.png'),
              ),
              customText.TitleText(
                text: 'Waste MX Wallet Balance',
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(height: _getSize(15),),
              customText.HeadlineText(
                text: walletBalance.toString(),
                textColor: Colors.lightGreen,
              ),
              SizedBox(height: _getSize(15),),
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
              SizedBox(height: _getSize(30),),
              RaisedButton(
                child: customText.BodyText(text: 'Make Payment', textColor: Colors.white,),
                onPressed: payable ? (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => WalletPayPage()
                  ));
                } : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}