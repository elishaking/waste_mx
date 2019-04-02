import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

class VendorHomePage extends StatelessWidget{
  //* Get data from server
  final Map<String, List<Map<String, dynamic>>> _wasteOffers = {
    'Household waste': [
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ],
    'Office waste': [
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ],
    'Sewage': [
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
      {'imageUrl': 'assets/organic.png', 'type': 'Organic', 'price': 'N20/kg'},
    ]
  };

  Widget _buildWasteListRow(String key){
    if(_wasteOffers[key] == null){
      return Container();
    } else{
      final List<Map<String, dynamic>> _wasteOffer = _wasteOffers[key];
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                children: _wasteOffer.map((Map<String, dynamic> wasteListItem) => Card(
                  child: Column(
                    children: <Widget>[
                      Image(image: AssetImage(wasteListItem['imageUrl']), height: 100,), //! change to network for production
                      customText.TitleText(text: wasteListItem['type'], textColor: Colors.black,),
                      customText.BodyText(text: wasteListItem['price'], textColor: Colors.black87,),
                      SizedBox(height: 20,)
                    ],
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
            _buildWasteListRow('Household waste'),
            SizedBox(height: 15,),
            _buildWasteListRow('Office waste'),
            SizedBox(height: 15,),
            _buildWasteListRow('Sewage'),
          ],
        ),
      ),
      ),
    );
  }
}