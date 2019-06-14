import 'package:flutter/material.dart';

import '../models/offering.dart';

import '../widgets/custom_text.dart' as customText;

import '../utils/responsive.dart';

import '../pages/select_offer_type.dart';

class WasteCategory extends StatelessWidget {
  final String imageUrl;
  final String wasteType;
  final String offeringType;

  WasteCategory(this.imageUrl, this.wasteType, this.offeringType);

  @override
  Widget build(BuildContext context) {
    List<String> textComponents = wasteType.split(" ");
    
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
            width: getSize(context, 50),
            height: getSize(context, 50),
            image: AssetImage(imageUrl),
          ),
          SizedBox(
            height: getSize(context, 15),
          ),
          Container(
            width: getSize(context, 140),
            alignment: Alignment.center,
            child: offeringType == OfferingType.dispose ? RichText(
              textAlign: TextAlign.center,

              text: TextSpan(
                style: Theme.of(context).textTheme.body1.merge(TextStyle(
                  color: Theme.of(context).primaryColor
                ),),
                children: [
                  TextSpan(
                    text: textComponents[0] + "\n",
                    style: Theme.of(context).textTheme.title.merge(TextStyle(
                      color: Theme.of(context).primaryColor
                    ))
                  ),
                  // if(offeringType == "OfferingType")
                  TextSpan(
                    text: textComponents[1]
                  )
                ]
              ),
            ) : customText.TitleText(text: wasteType, textColor: Theme.of(context).primaryColor,),
          )
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => SelectOfferType(wasteType, offeringType)));
      },
    );
  }
}