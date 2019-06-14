import 'package:flutter/material.dart';

class ViewOfferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sent Offer'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Offer Details/Status'),
        ),
      ),
    );
  }
}
