import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';
import '../widgets/custom_text.dart' as customText;

import './vendor_list.dart';

class DisposeWastePage extends StatelessWidget{
  final List<Map<String, dynamic>> _categories = [
    {
      'name': 'household_waste',
      'title': 'Household waste',
      'subtitle': 'Waste created at home',
      'icon': Icons.broken_image,
    },
    {
      'name': 'office_waste',
      'title': 'Office waste',
      'subtitle': 'Waste created at the Office',
      'icon': Icons.group_work,
    },
    {
      'name': 'liquid_waste',
      'title': 'Liquid Waste',
      'subtitle': 'Custom description ......',
      'icon': Icons.delete_outline,
    },
    {
      'name': 'hospital_waste',
      'title': 'Hospital Waste',
      'subtitle': 'Custom description ......',
      'icon': Icons.local_hospital,
    },
  ];

  List<Widget> _buildCategories(BuildContext context){
    return List.generate(_categories.length, (int index) => Card(
        child: Container(
          padding: EdgeInsets.all(5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(_categories[index]['icon']),
                title: Text(_categories[index]['title']),
                subtitle: Text(_categories[index]['subtitle']),
              ),
              ButtonTheme.bar( // make buttons use the appropriate styles for cards
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: const Text('SCHEDULE PICKUP'),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return VendorListPage();
                        }
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildCategoryWidget(BuildContext context, String title, String imageUrl, [dynamic route]){
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        children: <Widget>[
          Image(
            width: 110,
            height: 110,
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
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => route != null ? route : VendorListPage()
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
              _buildCategoryWidget(context, 'Household Waste', 'assets/house.png'),
              _buildCategoryWidget(context, 'Industrial Waste', 'assets/industrial.png')
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Agric Waste', 'assets/harvest.png'),
              _buildCategoryWidget(context, 'Bulk Waste', 'assets/bulk.png')
            ],
          ),
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildCategoryWidget(context, 'Nuclear Waste', 'assets/nuclear-plant.png'),
              _buildCategoryWidget(context, 'Other Waste', 'assets/throw-to-paper-bin.png')
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispose Waste'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(height: 200, color: Theme.of(context).primaryColor,),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(18),
              child: Column(
                children: <Widget>[
                  Image(
                    height: 50,
                    image: AssetImage('assets/garbage-can.png'),
                  ),
                  _buildCategoriesSection(context)
                ],
                // children: _buildCategories(context)
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: ButtomNavigationBar('dispose'),
    );
  }
}