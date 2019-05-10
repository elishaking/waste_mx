import 'package:flutter/material.dart';

import '../../models/dispose_offering.dart';
import '../../models/offering.dart';

// import '../widgets/bottom_navigation_bar.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/custom_text.dart' as customText;

import '../../utils/responsive.dart';

import '../select_offer_type.dart';

class DisposeWastePage extends StatelessWidget {
  /*
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
  */

/*
  List<Widget> _buildCategories(BuildContext context){
    return List.generate(_categories.length, (int index) => Card(
        child: Container(
          // padding: EdgeInsets.all(5),
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
*/

  Widget _buildCategoryWidget(
      BuildContext context, String wasteType, String imageUrl,
      [dynamic route]) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Theme.of(context).primaryColor)),
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: getSize(context, 30), vertical: getSize(context, 30)),
      child: Column(
        children: <Widget>[
          Image(
            width: getSize(context, 90),
            height: getSize(context, 90),
            image: AssetImage(imageUrl),
          ),
          SizedBox(
            height: getSize(context, 15),
          ),
          Container(
            width: getSize(context, 140),
            alignment: Alignment.center,
            child: customText.BodyText(
              text: wasteType,
              textColor: Theme.of(context).primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SelectOfferType(wasteType, OfferingType.dispose)));
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getSize(context, 30)),
      child: _buildAllCategories(context),
    );
  }

  Column _buildAllCategories(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(
                context, WasteType.householdWaste, 'assets/house.png'),
            _buildCategoryWidget(context, WasteType.industrialWaste,
                'assets/industrial.png')
          ],
        ),
        SizedBox(
          height: getSize(context, 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(
                context, WasteType.agricWaste, 'assets/harvest.png'),
            _buildCategoryWidget(
                context, WasteType.bulkWaste, 'assets/bulk.png')
          ],
        ),
        SizedBox(
          height: getSize(context, 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(context, WasteType.nuclearWaste,
                'assets/nuclear-plant.png'),
            _buildCategoryWidget(context, WasteType.otherWaste,
                'assets/throw-to-paper-bin.png')
          ],
        ),
      ],
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
          Container(
            height: getSize(context, 200),
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: getSize(context, 18)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getSize(context, 20)),
                    child: Image(
                      height: getSize(context, 50),
                      image: AssetImage('assets/garbage-can.png'),
                    ),
                  ),
                  _buildCategoriesSection(context)
                ],
                // children: _buildCategories(context)
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNav(1),
    );
  }
}
