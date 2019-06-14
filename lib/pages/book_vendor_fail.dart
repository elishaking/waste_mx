import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;


class BookVendorFailPage extends StatelessWidget {
  final String vendorName;

  BookVendorFailPage(this.vendorName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fail'),
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
            Image.asset('assets/fail.png'),
            customText.TitleText(text: 'Oh Snap!', textColor: Colors.red),
            customText.BodyText(
              text:
                  'Looks like something went wrong while working on your request.',
              textColor: Colors.black,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: customText.BodyText(
                text: 'Retry',
                textColor: Colors.white,
              ),
              onPressed: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (BuildContext context) => VendorListPage()
                // ));
              },
            )
          ],
        ),
      ),
    );
  }
}
