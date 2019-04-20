import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';
import '../../models/decluster_offering.dart';

import '../../widgets/custom_text.dart' as customText;
import '../../widgets/bottom_nav.dart';

class DeclusterPage extends StatelessWidget{
  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  Widget _buildCategoryWidget(
      BuildContext context, MainModel model, String declusterType, String imageUrl,
      [dynamic route]) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Theme.of(context).primaryColor)),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: _getSize(18), vertical: _getSize(18)),
      child: SizedBox(
        width: _getSize(120),
        height: _getSize(120),
        child: Column(
          children: <Widget>[
            Image(
              width: _getSize(70),
              height: _getSize(70),
              image: AssetImage(imageUrl),
            ),
            SizedBox(
              height: _getSize(15),
            ),
            customText.BodyText(
              text: declusterType,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      onPressed: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => route != null
        //         ? route
        //         : VendorListPage(model, declusterType, OfferingType.dispose)));
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Container(
          padding: EdgeInsets.symmetric(
              horizontal: _getSize(20), vertical: _getSize(30)),
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
          height: _getSize(15),
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
          height: _getSize(15),
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
          height: _getSize(15),
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
    _targetWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Decluster'),
        elevation: 0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: _getSize(200),
            color: Theme.of(context).primaryColor,
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(_getSize(18)),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: _getSize(20)),
                    child: Image(
                      height: _getSize(50),
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