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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          child: Column(
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
              OutlineButton(
                child: Text('View Statement'),
                onPressed: (){

                },
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder()
                ),
                child: Column(
                  children: <Widget>[
                    Text('Add money to wallet',),
                    SizedBox(height: 15,),
                    Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.attach_money),
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
            ],
          ),
        ),
      ),
    );
  }
}