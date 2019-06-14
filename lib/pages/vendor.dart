import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/offering.dart';

import '../widgets/custom_text.dart' as customText;
import '../widgets/rating.dart' as ratingWidget;

import './book_vendor.dart';
import './recycle/book_recycler.dart';

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
                  image: AssetImage(_vendor.imageUrl == null ? 'assets/profile.png' : _vendor.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                color: _vendor.verified ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(100)),
                            child: customText.BodyText(
                              text: _vendor.verified ? 'Verified' : "Not Verified",
                              textColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      ratingWidget.RatingDisplay(rating: _vendor.rating),
                      SizedBox(height: 20,),
                      // Divider(),
                      
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text("Phone"),
                        subtitle: Text(_vendor.phone),
                        trailing: Builder(
                          builder: (context) {
                            return IconButton(
                              icon: Icon(Icons.phone),
                              onPressed: (){
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Coming Soon"),
                                  duration: Duration(seconds: 3),
                                ));
                              },
                            );
                          }
                        ),
                      ),
                      Divider(),
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text("Distance"),
                        subtitle: Text("${_vendor.distance.toStringAsFixed(2)} km"),
                      ),
                      Divider(),
                      if(_vendor.address != null && _vendor.address.length > 0)
                        ...[
                          ListTile(
                            contentPadding: EdgeInsets.all(0),
                            title: Text("Address"),
                            subtitle: Text(_vendor.address),
                          ),
                          Divider()
                        ],
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: Text("Rate"),
                        subtitle: Text("NGN ${_vendor.rate}"),
                      ),
                      Divider(),
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
                      // Row(
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 10),
                      //       child: customText.BodyText(
                      //         text: "10 Wastes Collected",
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
              )
            ]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
        ),
        label: Text("Proceed", style: TextStyle(color: Colors.white),),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => _getOfferingType())),
      ),
    );
  }
}
