import 'package:flutter/material.dart';

import '../widgets/rating.dart' as ratingWidgets;
import '../widgets/custom_text.dart' as customText;

import './vendor.dart';
import './book_vendor.dart';

class VendorListPage extends StatelessWidget{
  Widget _buildVendorRating(int rating){
    return ratingWidgets.RatingDisplay(rating: rating,);
  }

  double _targetWidth = 0;

  double _getSize(final double default_1440){
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

    List<Map<String, dynamic>> _vendors = [
      {
        'id': '12290ol23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 5,
        'verified': true
      },
      {
        'id': '122ieo23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 4,
        'verified': false
      },
      {
        'id': '12fgh23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 3,
        'verified': true
      },
      {
        'id': '1222wssknn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 5,
        'verified': true
      },
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor List'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index){
            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Hero(
                      tag: _vendors[index]['id'],
                      child: CircleAvatar(child: Image.asset(_vendors[index]['imageUrl']),),
                    ),
                    title: Text(_vendors[index]['title'], style: TextStyle(fontSize: _getSize(18)),),
                    subtitle: _buildVendorRating(_vendors[index]['rating']),
                    trailing: Chip(
                      label: customText.BodyText(
                        text: _vendors[index]['verified'] ? 'Verified' : 'Not Verified',
                      ),
                      labelPadding: EdgeInsets.symmetric(horizontal: _getSize(10), vertical: 0),
                      backgroundColor: _vendors[index]['verified'] ? Colors.green : Colors.red,
                    ),
                    // onTap: (){
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (BuildContext context) => VendorPage(_vendors[index])
                    //   ));
                    // },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.add_circle_outline,
                              color: Theme.of(context).primaryColor,
                              size: _getSize(23),
                            ),
                            SizedBox(width: _getSize(10),),
                            customText.BodyText(
                              text: 'PLACE ORDER',
                              textColor: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => BookVendorPage()
                          ));
                        },
                      ),
                      FlatButton(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                            size: _getSize(23),),
                            SizedBox(width: _getSize(10),),
                            customText.BodyText(
                              text: 'DETAILS',
                              textColor: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => VendorPage(_vendors[index])
                          ));
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: _vendors.length,
        ),
      ),
    );
  }
}