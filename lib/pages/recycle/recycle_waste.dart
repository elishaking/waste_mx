import 'package:flutter/material.dart';

import '../../models/recycle_offering.dart';
import '../../models/offering.dart';

// import '../widgets/bottom_navigation_bar.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/custom_text.dart' as customText;
import '../../widgets/waste_category.dart';

import '../../utils/responsive.dart';

class RecycleWastePage extends StatelessWidget {

  Widget _buildCategoryWidget(
      BuildContext context, String wasteType, String imageUrl,
      [dynamic route]) {
    return WasteCategory(imageUrl, wasteType, OfferingType.recycle);
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
          height: getSize(context, 30),
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
          height: getSize(context, 30),
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
      padding: EdgeInsets.symmetric(vertical: getSize(context, 30)),
      child: _buildAllCategories(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recycle Waste'),
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
