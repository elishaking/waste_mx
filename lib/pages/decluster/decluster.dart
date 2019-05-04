import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';
import '../../models/decluster_offering.dart';

import '../../widgets/custom_text.dart' as customText;
import '../../widgets/bottom_nav.dart';

import '../../utils/responsive.dart';

import './subcategory_list.dart';

class DeclusterPage extends StatelessWidget{
  final Map<String, List<String>> _subCategories = {
    DeclusterType.vehicles: [
      'Cars', 'Trucks and Trailers', 'Motorcycles & Scooters',
      'Bicycles', 'Tricycles', 'Vehicle Parts & Accessories',
      'Aircrafts & Watercrafts', 'Mixed Items'
    ],
    DeclusterType.household: [
      'Office Wares', 'Mattrassess', 'Furniture', 'Dresses',
      'Doors and Gates', 'Refrigerators & Freezers', 'Phones',
      'Mixed Items'
    ]
  };

  Widget _buildCategoryWidget(
      BuildContext context, MainModel model, String declusterType, String imageUrl,
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
            width: getSize(context, 130),
            alignment: Alignment.center,
            child: customText.BodyText(
              text: declusterType,
              textColor: Theme.of(context).primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => SubCategoryListPage(declusterType, _subCategories[declusterType])
        ));
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: getSize(context, 30)),
          child: _buildAllCategories(context, model),
        );
      },
    );
  }

  Column _buildAllCategories(BuildContext context, MainModel model) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(
                context, model, DeclusterType.vehicles, 'assets/decluster/${DeclusterType.vehicles.toLowerCase()}.png'),
            _buildCategoryWidget(context, model, DeclusterType.bottles,
                'assets/decluster/${DeclusterType.bottles.toLowerCase()}.png')
          ],
        ),
        SizedBox(
          height: getSize(context, 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(
                context, model, DeclusterType.clothes, 'assets/decluster/${DeclusterType.clothes.toLowerCase()}.png'),
            _buildCategoryWidget(
                context, model, DeclusterType.appliances, 'assets/decluster/${DeclusterType.appliances.toLowerCase()}.png')
          ],
        ),
        SizedBox(
          height: getSize(context, 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(context, model, DeclusterType.furniture,
                'assets/decluster/${DeclusterType.furniture.toLowerCase()}.png'),
            _buildCategoryWidget(context, model, DeclusterType.household,
                'assets/decluster/${DeclusterType.household.toLowerCase()}.png')
          ],
        ),
        SizedBox(
          height: getSize(context, 30),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(context, model, DeclusterType.stationery,
                'assets/decluster/${DeclusterType.stationery.toLowerCase()}.png'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decluster'),
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
              padding: EdgeInsets.all(getSize(context, 18)),
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
      bottomNavigationBar: BottomNav(3),
    );
  }
}