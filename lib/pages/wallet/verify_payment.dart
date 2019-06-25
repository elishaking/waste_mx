import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:waste_mx/scoped_models/main.dart';

class VerifyPaymentPage extends StatefulWidget {
  final MainModel model;

  VerifyPaymentPage(this.model);

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
      ),
      body: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model){
          return model.isLoading ? Center(child: CircularProgressIndicator(),) 
            : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //todo: add successful/failed image graphic
                  Text("$_verificationMessage")
                ],
              ),
            );
        },
      ),
    );
  }
}