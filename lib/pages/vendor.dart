import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/offering.dart';

import '../widgets/custom_text.dart' as customText;
import '../widgets/rating.dart' as ratingWidget;

import './book_vendor.dart';
import './book_recycler.dart';

class VendorPage extends StatelessWidget {
  final Vendor _vendor;
  final String wasteType;
  final String offeringType;

  VendorPage(this._vendor, this.wasteType, this.offeringType);

  dynamic _getOfferingType() {
    if (offeringType == OfferingType.dispose) {
      return BookVendorPage(wasteType);
    } else if (offeringType == OfferingType.recycle) {
      return BookRecyclerPage(wasteType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //    title: Text(_vendor['title']),
      //  ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(_vendor.name,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              background: Hero(
                tag: _vendor.id,
                child: FadeInImage(
                  placeholder:
                      AssetImage('assets/profile.png'), //! some placeholder
                  image: AssetImage(_vendor.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                child: Center(
                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          customText.BodyText(
                            text: 'Last Login: 15min',
                            textColor: Colors.black54,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 10),
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(100)),
                            child: customText.BodyText(
                              text: 'Verified',
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child:
                            ratingWidget.RatingDisplay(rating: _vendor.rating),
                      ),
                      // Container(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: <Widget>[
                      //       RaisedButton(
                      //         child: Text('Chat'),
                      //         elevation: 0,
                      //         color: Colors.black12,
                      //         onPressed: (){

                      //         },
                      //       ),
                      //       RaisedButton(
                      //         child: Text('Call'),
                      //         elevation: 0,
                      //         color: Colors.black12,
                      //         onPressed: (){

                      //         },
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: customText.BodyText(
                              text: "10 Wastes Collected",
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => _getOfferingType())),
      ),
    );
  }
}
