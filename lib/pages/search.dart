import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).primaryColor
        ),
        elevation: 0,
        title: TextField(
          autofocus: true,
          style: TextStyle(
            fontSize: 20
          ),
          // decoration: InputDecoration(
            
          //   labelText: 'Search Vendors',
          // ),
        )
      ),
      body: Center(
        child: Text('Search Vendors - TODO'),
      ),
    );
  }
}
