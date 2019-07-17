import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';

import '../../widgets/custom_text.dart' as customText;

import '../../utils/responsive.dart';

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
  final double walletBalance = 0.0;

  double _mainOpacity = 0, _loadingOpacity = 1;

  @override
  void initState() {
    print(widget.model.client.name);
    // widget.model.loginWallet();
    widget.model.createPaystackCustomer();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.of(context).popUntil((Route route) => true);
          },
        ),
      ),
      body: 
      // false ? Center(
      //   child: Text("Wallet Temporarily Disabled"),
      // ) : 
      ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model){
          //todo: implement paystack error Stack Child
          if(model.isLoading){
            _mainOpacity = 0;
            _loadingOpacity = 1;
          } else{
            _mainOpacity = 1;
            _loadingOpacity = 0;
          }
          return Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: _mainOpacity,
                duration: Duration(milliseconds: 500),
                child: _buildWalletPageBody(context, model),
              ),
              AnimatedOpacity(
                opacity: _loadingOpacity,
                duration: Duration(milliseconds: 500),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Container _buildWalletPageBody(BuildContext context, MainModel model) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              width: getSize(context, 200),
              image: AssetImage('assets/wallet-enclosed.png'),
            ),
            SizedBox(height: getSize(context, 30),),
            customText.TitleText(
              text: 'Wallet Balance',
              textColor: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: getSize(context, 15),
            ),
            customText.HeadlineText(
              text: "NGN ${model.walletBalance}",//"${model.wallet.localCurrency} ${model.wallet.balance}",
              textColor: Colors.lightGreen,
            ),
            SizedBox(
              height: getSize(context, 50),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                OutlineButton(
                  child: Text('View Statement'),
                  onPressed: () {},
                ),
                SizedBox(width: 20,),
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
            widget.payable ? RaisedButton(
              child: customText.BodyText(
                text: 'Make Payment',
                textColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        WalletPayPage()));
              }
            ) : Container()
          ],
        ),
      ),
    );
  }
}
