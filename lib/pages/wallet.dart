import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import '../widgets/custom_text.dart' as customText;

import '../utils/responsive.dart';

import './credit_wallet.dart';
import './wallet_pay.dart';

class WalletPage extends StatefulWidget {
  final bool payable;
  final MainModel model;

  WalletPage(this.model, this.payable);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final double walletBalance = 5000.0;

  @override
  void initState() {
    print(widget.model.client.name);
    super.initState();
  }

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
                width: getSize(context, 200),
                image: AssetImage('assets/wallet-enclosed.png'),
              ),
              customText.TitleText(
                text: 'Waste MX Wallet Balance',
                textColor: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: getSize(context, 15),
              ),
              customText.HeadlineText(
                text: walletBalance.toString(),
                textColor: Colors.lightGreen,
              ),
              SizedBox(
                height: getSize(context, 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('View Statement'),
                    onPressed: () {},
                  ),
                  OutlineButton(
                    child: Text('Credit Wallet'),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CreditWalletPage()));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: getSize(context, 30),
              ),
              RaisedButton(
                child: customText.BodyText(
                  text: 'Make Payment',
                  textColor: Colors.white,
                ),
                onPressed: widget.payable
                    ? () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                WalletPayPage()));
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
