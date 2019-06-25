import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:waste_mx/pages/home.dart';
import 'package:waste_mx/scoped_models/main.dart';
import 'package:waste_mx/widgets/custom_text.dart';

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
            : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  //todo: add successful/failed image graphic
                  HeadlineText(text: "${_verificationMessage ?? "Verification Unsuccessful"}", textColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,)
                ],
              ),
            );
        },
      ),
    );
  }
}