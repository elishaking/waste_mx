import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './waste_details.dart';

class VendorHomePage extends StatelessWidget{
  //* Get data from server
  final Map<String, List<Map<String, dynamic>>> _wasteOffers = {
    'Household waste': [
      {'id': '00223s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': '2er2f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': 'qw2s23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ],
    'Office waste': [
      {'id': '222zx3s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': '2wjd2f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': '22pls23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ],
    'Sewage': [
      {'id': '222p3s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': '22f23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'id': '22s23s', 'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ]
  };

  Widget _buildWasteListRow(BuildContext context, String key){
    if(_wasteOffers[key] == null){
      return Container();
    } else{
      final List<Map<String, dynamic>> _wasteOffer = _wasteOffers[key];
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            customText.TitleText(
              text: key,
              textColor: Colors.black,
              // textAlign: TextAlign.left,
            ),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _wasteOffer.map((Map<String, dynamic> wasteListItem) => GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => WasteDetailsPage(wasteListItem)
                    ));
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: wasteListItem['id'],
                          child: Image(image: AssetImage(wasteListItem['imageUrl']), height: 110,),  //! change to network for production
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              customText.TitleText(text: wasteListItem['type'], textColor: Colors.black,),
                              customText.BodyText(text: wasteListItem['price'], textColor: Colors.black87,),
                            ],
                          )
                        ),
                        SizedBox(height: 10,)
                        // Row(
                        //   mainAxisSize: MainAxisSize.min,
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: <Widget>[
                        //     FlatButton(
                        //       child: Text('VIEW'),
                        //       onPressed: (){

                        //       },
                        //     )
                        //   ],
                        // )
                      ],
                    ),
                  ),
                )).toList(),
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Waste MX'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){

            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
        child: Column(
          children: <Widget>[
            _buildWasteListRow(context, 'Household waste'),
            SizedBox(height: 15,),
            _buildWasteListRow(context, 'Office waste'),
            SizedBox(height: 15,),
            _buildWasteListRow(context, 'Sewage'),
          ],
        ),
      ),
      ),
    );
  }
}