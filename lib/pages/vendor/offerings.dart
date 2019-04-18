import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';
import '../../models/dispose_offering.dart';

import '../../widgets/custom_text.dart' as customText;

import './offering_details.dart';

class OfferingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OfferingsPageState();
  }
}

class _OfferingsPageState extends State<OfferingsPage> {
  // final List<DisposeOffering> _offerings = [
  //   DisposeOffering(
  //     id: 'skwjwmms',
  //     name: 'Household Waste',
  //     iconUrl: 'assets/house.png',
  //     price: '5000',
  //     rate: '1000',
  //     numberOfBins: '5',
  //     clientName: 'John Doe',
  //     clientLocation: 'Allen avenue, Ikeja, Lagos',
  //     date: 'Feb 1'
  //   ),
  //   DisposeOffering(
  //     id: 'sksnxnxn',
  //     name: 'Industrial Waste',
  //     iconUrl: 'assets/industrial.png',
  //     price: '3000',
  //     rate: '1000',
  //     numberOfBins: '3',
  //     clientName: 'Jane Doe',
  //     clientLocation: 'Xeno avenue, Ikeja, Lagos',
  //     date: 'Feb 1'
  //   ),
  //   DisposeOffering(
  //     id: 'sksnxnwwxn',
  //     name: 'Industrial Waste',
  //     iconUrl: 'assets/bulk.png',
  //     price: '3000',
  //     rate: '1000',
  //     numberOfBins: '3',
  //     clientName: 'Jane Doe',
  //     clientLocation: 'Xeno avenue, Ikeja, Lagos',
  //     date: 'Feb 1'
  //   ),
  // ];
  Map<String, List> _offerings;

  List<Widget> _buildOfferings(BuildContext context) {
    List<String> _offeringNames = _offerings.keys;
    return List.generate(_offeringNames.length, (index) {
      List _offeringList = _offerings[_offeringNames[index]];
      return _offeringList.length > 0
          ? Container()
          : Container(
              child: Column(
                children: <Widget>[
                  customText.TitleText(
                    text: _offeringNames[index],
                    textColor: Colors.black,
                  ),
                  Column(
                    children: List.generate(
                        _offeringList.length,
                        (index) => Card(
                              child: Container(
                                padding: EdgeInsets.only(top: 13),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Hero(
                                        tag: _offeringList[index].id,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: Image.asset(
                                              _offeringList[index].iconUrl),
                                        ),
                                      ),
                                      title: customText.TitleText(
                                        text: _offeringList[index].clientName,
                                        textColor: Colors.black,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 7,
                                                      vertical: 5),
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                'NGN ${_offeringList[index].price} for ${_offeringList[index].numberOfBins} bins at ${_offeringList[index].rate} per bin',
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            customText.BodyText(
                                              text: _offeringList[index]
                                                  .clientLocation,
                                              textColor: Colors.grey,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: customText.BodyText(
                                                text: '0.2km',
                                                textColor: Colors.black,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Text(_offeringList[index].date),
                                    ),
                                    ButtonTheme.bar(
                                      child: ButtonBar(
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text('VIEW'),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          OfferingDetails(
                                                              _offeringList[
                                                                  index])));
                                            },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                  )
                ],
              ),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offerings'),
      ),
      body: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          model.fetchOfferings().then((Map<String, List> offerings) {
            setState(() {
              _offerings = offerings;
            });
          });
          return model.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildOfferings(context),
                      // children: <Widget>[
                      //   customText.TitleText(
                      //     text: 'Requests',
                      //     textColor: Colors.black,
                      //   ),
                      //   SizedBox(height: 5,),
                      //   _buildOfferings(context)
                      // ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
