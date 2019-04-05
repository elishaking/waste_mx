import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

import './vendor_list.dart';

class DisposeWastePage extends StatelessWidget{
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Household waste',
      'subtitle': 'Waste created at home',
      'icon': Icons.broken_image,
    },
    {
      'title': 'Household waste',
      'subtitle': 'Waste created at home',
      'icon': Icons.broken_image,
    },
    {
      'title': 'Household waste',
      'subtitle': 'Waste created at home',
      'icon': Icons.broken_image,
    },
  ];

  List<Widget> _buildCategories(){
    
  }

  @override
  Widget build(BuildContext context) {
    void _pushRoute(route){
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return route;
          }
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Dispose Waste'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.broken_image),
                        title: Text('Household waste'),
                        subtitle: Text('Waste created at home'),
                      ),
                      ButtonTheme.bar( // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('SCHEDULE PICKUP'),
                              onPressed: () {
                                _pushRoute(VendorListPage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.group_work),
                        title: Text('Office waste'),
                        subtitle: Text('Waste created at the Office'),
                      ),
                      ButtonTheme.bar( // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('SCHEDULE PICKUP'),
                              onPressed: () {
                                _pushRoute(VendorListPage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.delete_outline),
                        title: Text('Liquid Waste'),
                        subtitle: Text('Custom description ......'),
                      ),
                      ButtonTheme.bar( // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('SCHEDULE PICKUP'),
                              onPressed: () {
                                _pushRoute(VendorListPage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.local_hospital),
                        title: Text('Hospital waste'),
                        subtitle: Text('Custom description ......'),
                      ),
                      ButtonTheme.bar( // make buttons use the appropriate styles for cards
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('SCHEDULE PICKUP'),
                              onPressed: () {
                                _pushRoute(VendorListPage());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtomNavigationBar('dispose'),
    );
  }
}