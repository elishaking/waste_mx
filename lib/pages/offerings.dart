import 'package:flutter/material.dart';

import '../models/dispose_offering.dart';

import '../widgets/custom_text.dart' as customText;

class OfferingsPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OfferingsPageState();
  }
}

class _OfferingsPageState extends State<OfferingsPage>{
  final List<DisposeOffering> _offerings = [
    DisposeOffering(
      price: '5000',
      rate: '1000',
      numberOfBins: '5',
      clientName: 'John Doe',
      clientLocation: 'Allen avenue, Ikeja, Lagos',
      date: 'Feb 1'
    ),
    DisposeOffering(
      price: '3000',
      rate: '1000',
      numberOfBins: '3',
      clientName: 'Jane Doe',
      clientLocation: 'Xeno avenue, Ikeja, Lagos',
      date: 'Feb 1'
    ),
  ];

  Widget _buildOfferings(BuildContext context){
    return Container(
      child: Column(
        children: List.generate(_offerings.length, (index) => Card(
          child: Container(
            padding: EdgeInsets.only(top: 13),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(child: Image.asset('assets/clean_bin_angle.png'),),
                  title: customText.TitleText(
                    text: _offerings[index].clientName,
                    textColor: Colors.black,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('NGN ${_offerings[index].price} for ${_offerings[index].numberOfBins} bins at ${_offerings[index].rate} per bin',
                            style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
                          ),
                        ),
                        customText.BodyText(text: _offerings[index].clientLocation, textColor: Colors.grey,),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: customText.BodyText(
                            text: '0.2km', textColor: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  trailing: Text(_offerings[index].date),
                ),
                ButtonTheme.bar(
                  child: ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        child: Text('DETAILS'),
                        onPressed: (){

                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offerings'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              customText.TitleText(
                text: 'Requests',
                textColor: Colors.black,
              ),
              SizedBox(height: 5,),
              _buildOfferings(context)
            ],
          ),
        ),
      ),
    );
  }
}