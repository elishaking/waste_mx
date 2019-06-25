import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CardDetailsPage extends StatefulWidget {
  final String authorizationUrl;

  CardDetailsPage(this.authorizationUrl);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.authorizationUrl,
      appBar: AppBar(
        title: Text("Card Details"),
      ),
    );
  }
}