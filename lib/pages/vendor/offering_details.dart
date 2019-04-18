import 'package:flutter/material.dart';

import '../../models/dispose_offering.dart';

import '../../widgets/custom_text.dart' as customText;

import './offering_accepted.dart';

class OfferingDetails extends StatelessWidget {
  final DisposeOffering offering;

  OfferingDetails(this.offering);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(offering.name),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Column(
            children: <Widget>[
              Hero(
                tag: offering.id,
                child: Container(
                  child: Image(
                    image: AssetImage(offering.iconUrl),
                    height: 120,
                    width: 120,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  OutlineButton(
                    child: Text('Decline'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  RaisedButton(
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.white),
                    ),
                    // elevation: 0,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OfferingAcceptedPage(offering)),
                          (Route route) => false);
                    },
                  )
                ],
              ),
              // ListTile(
              //   title: Text('Client name'),
              //   subtitle: Text(offering.clientName),
              // ),
              // Divider(),
              ListTile(
                title: Text('Location'),
                subtitle: Text(offering.clientLocation),
              ),
              Divider(),
              ListTile(
                title: Text('Distance'),
                subtitle: Text('0.2km'),
              ),
              Divider(),
              ListTile(
                title: Text('Price'),
                subtitle: Text(offering.price),
              ),
              Divider(),
              ListTile(
                title: Text('Rate'),
                subtitle: Text(offering.rate),
              ),
              Divider(),
              ListTile(
                title: Text('Number of Bins'),
                subtitle: Text(offering.numberOfBins),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
