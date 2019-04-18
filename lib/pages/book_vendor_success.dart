import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './view_offer.dart';

class BookVendorSuccessPage extends StatelessWidget {
  final String vendorName;

  BookVendorSuccessPage(this.vendorName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: <Widget>[
            Image.asset('assets/success.png'),
            customText.TitleText(
                text: 'Success!', textColor: Theme.of(context).primaryColor),
            customText.BodyText(
              text:
                  'Your offer has been placed and you will get a call soon from a vendor.',
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: customText.BodyText(
                text: 'View Offer',
                textColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => ViewOfferPage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
