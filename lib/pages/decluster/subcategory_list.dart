import 'package:flutter/material.dart';

// import '../../models/decluster_offering.dart';

// import '../select_offer_type.dart';
import './create_offer.dart';

class SubCategoryListPage extends StatelessWidget{
  final String declusterType;
  final List<String> categories;

  SubCategoryListPage(this.declusterType, this.categories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.declusterType)
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: List.generate(categories.length, (int index) => _buildSubCategory(context, index)),
      ),
    );
  }

  Column _buildSubCategory(BuildContext context, int index) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(categories[index]),
          trailing: Icon(Icons.arrow_forward_ios, size: 17,),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              // builder: (BuildContext context) => SelectOfferType(declusterType, OfferingType.decluster)
              builder: (BuildContext context) => CreateOfferPage(declusterType, categories[index])
            ));
          },
        ),
        Divider()
      ],
    );
  }
}