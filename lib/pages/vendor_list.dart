import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

import '../models/user.dart';
import '../models/offering.dart';

import '../widgets/rating.dart' as ratingWidgets;
import '../widgets/custom_text.dart' as customText;

import './vendor.dart';
import './book_vendor.dart';
import './recycle/book_recycler.dart';

class VendorListPage extends StatefulWidget {
  final MainModel model;
  final String wasteType;
  final String offeringType;

  VendorListPage(this.model, this.wasteType, this.offeringType);

  @override
  _VendorListPageState createState() => _VendorListPageState();
}

class _VendorListPageState extends State<VendorListPage> {
  List<Vendor> _vendors = [
    Vendor(
        id: '12290olmu3nn',
        name: 'Json Martinz Partners',
        imageUrl: 'assets/profile.png',
        rate: 150,
        rating: 5,
        verified: true),
    Vendor(
        id: '12290olldnn',
        name: 'Json Doe Partners',
        imageUrl: 'assets/profile.png',
        rate: 70,
        rating: 3,
        verified: false),
    Vendor(
        id: '12kk0ol23nn',
        name: 'John Ket An',
        imageUrl: 'assets/profile.png',
        rate: 150,
        rating: 5,
        verified: true),
    Vendor(
        id: '12290osdd3nn',
        name: 'Json Martinz Chris',
        imageUrl: 'assets/profile.png',
        rate: 200,
        rating: 5,
        verified: true),
    Vendor(
        id: '122ffol23nn',
        name: 'Json Jane Menk',
        imageUrl: 'assets/profile.png',
        rate: 100,
        rating: 4,
        verified: true),
  ];

  List<Vendor> _closestVendors = [];
  bool _showVendors = false;

  @override
  initState() {
    widget.model.fetchClosestVendors().then((List<Vendor> closestVendors){
      // print(closestVendors);
      if(closestVendors != null && closestVendors.length > 0) {
        _closestVendors = closestVendors;
        setState(() {
         _showVendors = true; 
        });
      }
    });
    // print(widget.model.client.pos);
    super.initState();
  }

  Widget _buildVendorRating(int rating) {
    return ratingWidgets.RatingDisplay(
      rating: rating,
    );
  }

  Container _buildVendorList() {
    List<Vendor> vendors = _closestVendors;
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _buildVendor(context, vendors[index]);
        },
        itemCount: vendors.length,
      ),
    );
  }

  dynamic _getOfferingType() {
    if (widget.offeringType == OfferingType.dispose) {
      return BookVendorPage(widget.wasteType);
    } else if (widget.offeringType == OfferingType.recycle) {
      return BookRecyclerPage(widget.wasteType);
    }
  }

  String _getUnit() {
    if (widget.offeringType == OfferingType.dispose) {
      return 'bin';
    } else if (widget.offeringType == OfferingType.recycle) {
      return 'kg';
    } else {
      return 'unit';
    }
  }

  Card _buildVendor(BuildContext context, Vendor vendor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Hero(
                tag: vendor.id,
                child: CircleAvatar(
                  backgroundImage: AssetImage(vendor.imageUrl == null ? 'assets/profile.png' : vendor.imageUrl),
                ),
              ),
              title: Text(vendor.name),
              subtitle: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildVendorRating(vendor.rating),
                    // SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(top: 7),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(100)),
                      child: customText.BodyText(
                        text: 'NGN ${vendor.rate.toString()} per ${_getUnit()}',
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    vendor.distance == null ? customText.BodyText(text: "Distance Unknown", textColor: Colors.grey,) : customText.BodyText(text: '${vendor.distance.toStringAsFixed(2)} km', textColor: Colors.green.shade700,)
                  ],
                ),
              ),
              trailing: customText.BodyText(
                text: vendor.verified ? 'Verified' : 'Not Verified',
                textColor: vendor.verified ? Colors.green : Colors.red,
              ),
              // onTap: (){
              //   Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => VendorPage(vendor)
              //   ));
              // },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        color: Theme.of(context).primaryColor,
                        size: _getSize(23),
                      ),
                      SizedBox(
                        width: _getSize(10),
                      ),
                      customText.BodyText(
                        text: 'DETAILS',
                        textColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => VendorPage(
                            vendor, widget.wasteType, widget.offeringType)));
                  },
                ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).primaryColor,
                        size: _getSize(23),
                      ),
                      SizedBox(
                        width: _getSize(10),
                      ),
                      customText.BodyText(
                        text: 'PLACE ORDER',
                        textColor: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => _getOfferingType()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor List'),
      ),
      body: !_showVendors
              ? Center(
                  child: CircularProgressIndicator(),
                )
              // : _buildVendorList(
              //     model.vendors != null ? model.vendors : _vendors);
              :_buildVendorList()
      // ScopedModelDescendant<MainModel>(
      //   builder: (BuildContext context, Widget child, MainModel model) {
      //     return model.isLoading
      //         ? Center(
      //             child: CircularProgressIndicator(),
      //           )
      //         // : _buildVendorList(
      //         //     model.vendors != null ? model.vendors : _vendors);
      //         :_buildVendorList(_vendors);
      //   },
      // ),
    );
  }
}
