import 'package:flutter/material.dart';

import '../models/recycle_offering.dart';
import '../models/offering.dart';

// import '../widgets/bottom_navigation_bar.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/custom_text.dart' as customText;

import './select_offer_type.dart';

class RecycleWastePage extends StatelessWidget {
  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  Widget _buildCategoryWidget(
      BuildContext context, String wasteType, String imageUrl,
      [dynamic route]) {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: Theme.of(context).primaryColor)),
      color: Colors.white,
      padding: EdgeInsets.only(
          left: _getSize(18), right: _getSize(18), top: _getSize(23)),
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
              text: wasteType,
              textColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SelectOfferType(wasteType, OfferingType.dispose)));
      },
    );
  }

  Column _buildAllCategories(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(context, RecycleWasteType.plastics,
                'assets/plastic-bottle.png'),
            _buildCategoryWidget(context, RecycleWasteType.glass,
                'assets/thick-magnet.png')
          ],
        ),
        SizedBox(
          height: _getSize(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(
                context, RecycleWasteType.glass, 'assets/glass.png'),
            _buildCategoryWidget(context, RecycleWasteType.paper,
                'assets/stacked-print-products.png')
          ],
        ),
        SizedBox(
          height: _getSize(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildCategoryWidget(context, RecycleWasteType.nuclear,
                'assets/incineration.png'),
            _buildCategoryWidget(context, RecycleWasteType.otherWaste,
                'assets/throw-to-paper-bin.png')
          ],
        ),
      ],
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _getSize(20), vertical: _getSize(30)),
      child: _buildAllCategories(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle Waste'),
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
                      image: AssetImage('assets/eco-factory-solid.png'),
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
      bottomNavigationBar: BottomNav(2),
    );
  }
}
