import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:waste_mx/models/transaction.dart';
import 'package:waste_mx/pages/home.dart';
import 'package:waste_mx/pages/wallet/wallet.dart';
import 'package:waste_mx/scoped_models/main.dart';
import 'package:waste_mx/widgets/custom_text.dart';

class VerifyPaymentPage extends StatefulWidget {
  final MainModel model;
  final double amount;

  VerifyPaymentPage(this.model, this.amount);

  @override
  _VerifyPaymentPageState createState() => _VerifyPaymentPageState();
}

class _VerifyPaymentPageState extends State<VerifyPaymentPage> {
  String _verificationMessage = "Payment Unsuccessful";

  @override
  void initState() {
    widget.model.verifyPaystackTransaction().then((String verificationMessage){
      _verificationMessage = verificationMessage;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Status"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: (){
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (BuildContext context) => HomePage()
              ), (Route route) => false);
            },
          )
        ],
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model){
          return model.isLoading ? Center(child: CircularProgressIndicator(),) 
            : (){
              if(model.transactionSuccess){
                Timer(Duration(seconds: 3), (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => WalletPage(model, model.offeringPayable)
                  ));
                });
                model.addTransaction(Transaction(
                  amount: widget.amount,
                  pending: false,
                  type: TransactionType.wallet,
                  subType: TransactionSubType.credit,
                  initiatedByClient: model.vendor == null,
                  initiatedByVendor: model.client == null,
                  clientDetails: model.client == null ? null : ClientDetails(
                    clientId: model.client.id,
                    clientName: model.client.name
                  ),
                  vendorDetails: model.vendor == null ? null : VendorDetails(
                    vendorId: model.vendor.id,
                    vendorName: model.vendor.name
                  )
                ));
              }
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //todo: add successful/failed image graphic
                    HeadlineText(text: "${_verificationMessage ?? "Verification Unsuccessful"}", textColor: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,)
                  ],
                ),
              );
            }();
        },
      ),
    );
  }
}