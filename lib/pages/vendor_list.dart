import 'package:flutter/material.dart';

class VendorListPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor List'),
      ),
      body: Center(
        child: Text('List of Vendors'),
      ),
    );
  }
}