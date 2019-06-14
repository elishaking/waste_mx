import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import '../utils/assets.dart';
import '../utils/responsive.dart';

import '../widgets/custom_text.dart' as customText;

import './vendor_list.dart';
import './book_vendor.dart';

class SelectOfferType extends StatefulWidget{
  final String wasteType;
  final String offeringType;

  SelectOfferType(this.wasteType, this.offeringType);

  @override
  _SelectOfferTypeState createState() => _SelectOfferTypeState();
}

class _SelectOfferTypeState extends State<SelectOfferType> {
  // bool _open = false, _closed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model){
              return _buildTypes(context, model);
            },
          ),
        ),
      ),
    );
  }

  Column _buildTypes(BuildContext context, MainModel model) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              image: AssetImage(ImageAssets.logo),
              height: getSize(context, 150),
            ),
            SizedBox(height: getSize(context, 70),),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: customText.TitleText(
                text: 'How would you like to proceed',
                textColor: Colors.black,
                textAlign: TextAlign.center,
              ),
            ),
            OutlineButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListTile(
                title: Text('Create Open Offer'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('This creates an offer for all vendors to see and place a pickup request'),
                    // SizedBox(height: 10,),
                    // Text('70 NGN transaction fee')
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                // selected: _open,
                // onTap: () {
                //   // setState(() {
                //   //   _open = true;
                //   //   _closed = false;
                //   // });
                // },
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BookVendorPage(widget.wasteType)
                ));
              },
            ),
            SizedBox(height: 30,),
            OutlineButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: ListTile(
                title: Text('Engage Vendor'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('This creates an offer for just one vendor to see and place a pickup request'),
                    // SizedBox(height: 10,),
                    // Text('50 NGN transaction fee')
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                // selected: _closed,
                // onTap: () {
                //   // setState(() {
                //   //   _closed = true;
                //   //   _open = false;
                //   // });
                // },
              ),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => VendorListPage(model, widget.wasteType, widget.offeringType)
                ));
              },
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 30),
            //   child: ScopedModelDescendant<MainModel>(
            //     builder: (BuildContext context, Widget child, MainModel model){
            //       return RaisedButton(
            //         child: Text('Next'),
            //         textColor: Colors.white,
            //         onPressed: () {
            //           Navigator.of(context).push(MaterialPageRoute(
            //               builder: (BuildContext context) => _closed ? 
            //               VendorListPage(model, widget.wasteType, widget.offeringType)
            //               : BookVendorPage(widget.wasteType)
            //           ));
            //         },
            //       );
            //     },
            //   ),
            // )
          ],
        );
  }
}