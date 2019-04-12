import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './waste_details.dart';
import './dispose_waste.dart';
import './recycle_waste.dart';
import './wallet.dart';

class VendorHomePage extends StatelessWidget{
  final double pad_vertical = 13.0;

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

  double _targetWidth = 0;

  double _getSize(final double default_1440){
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  Widget _buildTopSection(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/waste_home.jpg'),
          colorFilter: ColorFilter.mode(
            Colors.black54,
            BlendMode.darken
          ),
          fit: BoxFit.cover
        ),
      ),
      child: Column(
        children: <Widget>[
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
          //   child: Text(
          //     'You earned 50 points just for installation, check your wallet',
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // OutlineButton(
          //   child: Text('Search vendor recycler'),
          // ),
          SizedBox(height: 30,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: pad_vertical),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 13.5),
                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(0)
                      ),
                    ),
                    child: Text('Search vendor recycler'),
                    onPressed: (){
                      Navigator.pushNamed(context, 'search');
                    },
                  ),
                ),
                FlatButton(
                  child: Icon(Icons.search),
                  color: Theme.of(context).accentColor,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        topRight: Radius.circular(100),
                        bottomRight: Radius.circular(100)
                    ),
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'search');
                  },
                )
              ],
            ),
            /*TextField(
                onTap: () => Navigator.pushNamed(context, 'search'),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Search vendor recycler',
                    suffixIcon: Icon(Icons.search)
                ),
              )*/
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: pad_vertical, bottom: 0, left: 10, right: 10),
            child: Text(
              'Make money with waste',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 5, bottom: 18, left: 10, right: 10),
            child: Text(
              'Get access to waste collectors, scavengers, recycling agents/centers, de-clusters, etc',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildCategoryWidget(BuildContext context, String title, String imageUrl, [dynamic route]){
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      borderSide: BorderSide(color: Theme.of(context).primaryColor),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: pad_vertical),
      child: Column(
        children: <Widget>[
          Image(
            width: _getSize(110),
            height: _getSize(110),
            image: AssetImage(imageUrl),
          ),
          SizedBox(height: 15,),
          customText.BodyText(
            text: title,
            textColor: Theme.of(context).primaryColor,
          )
        ],
      ),
      onPressed: (){
        if(route == null) return;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => route
        ));
      },
    );
  }
  
  Widget _buildCategoriesSection(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Dispose Waste', 'assets/recycling-bin.png', DisposeWastePage()),
              _buildCategoryWidget(context, 'Recycle Waste', 'assets/eco-factory.png', RecycleWastePage())
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'De-clustering', 'assets/target.png'),
              _buildCategoryWidget(context, 'Sewage', 'assets/sewage.png')
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Upcycling', 'assets/creative.png'),
              _buildCategoryWidget(context, 'Info Center', 'assets/analysis.png')
            ],
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

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
              // _buildWasteListRow(context, 'Household waste'),
              // SizedBox(height: 15,),
              // _buildWasteListRow(context, 'Office waste'),
              // SizedBox(height: 15,),
              // _buildWasteListRow(context, 'Sewage'),
              _buildTopSection(context),
              _buildCategoriesSection(context),
            ],
          ),
        ),
      ),
    );
  }
}