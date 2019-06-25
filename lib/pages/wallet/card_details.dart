import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:waste_mx/pages/wallet/verify_payment.dart';
import 'package:waste_mx/scoped_models/main.dart';

class CardDetailsPage extends StatefulWidget {
  final String authorizationUrl;

  CardDetailsPage(this.authorizationUrl);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    // _flutterWebviewPlugin.onUrlChanged.listen((onData){
    //   print("url changed");
    //   print(onData);
    // });

    // _flutterWebviewPlugin.onProgressChanged.listen((onData){
    //   print("progress changed");
    //   print(onData);
    // });

    // _flutterWebviewPlugin.onStateChanged.listen((onData){
    //   print("state changed");
    //   print(onData);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.authorizationUrl,
      withJavascript: true,
      appBar: AppBar(
        title: Text("Card Details"),
      ),
      persistentFooterButtons: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model){
                return FloatingActionButton.extended(
                  foregroundColor: Colors.white,
                  label: Text("Proceed"),
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => VerifyPaymentPage(model)
                    ));
                  },
                );
              },
            ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();

    super.dispose();
  }
}