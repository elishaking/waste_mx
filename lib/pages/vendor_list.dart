import 'package:flutter/material.dart';

import './vendor.dart';

class VendorListPage extends StatelessWidget{
  Widget _buildVendorRating(int rating){
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 20
      ),
      child: Row(
        children: <Widget>[
          rating > 0 ? Icon(Icons.star,) : Icon(Icons.star_border),
          rating > 1 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 2 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 3 ? Icon(Icons.star) : Icon(Icons.star_border),
          rating > 4 ? Icon(Icons.star) : Icon(Icons.star_border),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _vendors = [
      {
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 5
      },
      {
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 4
      },
      {
        'imageUrl': 'assets/profile.png',
        'title': 'Json Martinz Partners',
        'rating': 3
      },
      {
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
                  leading: CircleAvatar(child: Image.asset(_vendors[index]['imageUrl']),),
                  title: Text(_vendors[index]['title'], style: TextStyle(fontSize: 18),),
                  subtitle: _buildVendorRating(_vendors[index]['rating']),
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => VendorPage()
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