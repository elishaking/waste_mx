import 'package:flutter/material.dart';

import './vendor.dart';

import '../widgets/rating.dart' as ratingWidgets;

class VendorListPage extends StatelessWidget{
  Widget _buildVendorRating(int rating){
    return ratingWidgets.RatingDisplay(rating: rating,);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _vendors = [
      {
        'id': '12290ol23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 5
      },
      {
        'id': '122ieo23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 4
      },
      {
        'id': '12fgh23nn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 3
      },
      {
        'id': '1222wssknn',
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 5
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
            return Column(
              children: <Widget>[
                ListTile(
                  leading: Hero(
                    tag: _vendors[index]['id'],
                    child: CircleAvatar(child: Image.asset(_vendors[index]['imageUrl']),),
                  ),
                  title: Text(_vendors[index]['title'], style: TextStyle(fontSize: 18),),
                  subtitle: _buildVendorRating(_vendors[index]['rating']),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VendorPage(_vendors[index])
                    ));
                  },
                ),
                Divider()
              ],
            );
          },
          itemCount: _vendors.length,
        ),
      ),
    );
  }
}