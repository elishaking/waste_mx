import 'package:flutter/material.dart';

import '../../models/dispose_offering.dart';

import '../../widgets/custom_text.dart' as customText;

import './transactions.dart';

class OfferingAcceptedPage extends StatelessWidget {
  final DisposeOffering offering;

  OfferingAcceptedPage(this.offering);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offering Accepted'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>
                Navigator.of(context).pushReplacementNamed('vendor_home'),
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            children: <Widget>[
              Hero(
                tag: offering.id,
                child: Container(
                  child: Image(
                    image: AssetImage('assets/clean_bin_angle.png'),
                    height: 120,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: customText.TitleText(
                  text: offering.clientName,
                  textColor: Colors.black,
                ),
              ),
              customText.BodyText(
                text: offering.date,
                textColor: Colors.blueGrey,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(100)),
                child: customText.BodyText(
                  text:
                      'Your transaction is in Escrow. Your wallet will be credited once the client confirms completion of waste pickup',
                  textColor: Theme.of(context).primaryColor,
                  textOverflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Expanded(child: Container(),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('View Offerings'),
                    onPressed: () {},
                  ),
                  RaisedButton(
                    child: Text(
                      'Track Transactions',
                      style: TextStyle(color: Colors.white),
                    ),
                    // elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  TrackTransactionsPage()),
                          (Route route) => false);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
