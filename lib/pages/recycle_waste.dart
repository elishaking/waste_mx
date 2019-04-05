import 'package:flutter/material.dart';

import '../widgets/bottom_navigation_bar.dart';

class RecycleWastePage extends StatelessWidget{
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
        title: Text('Recycle Waste'),
      ),
      body: Center(
        child: Text('Recycle waste'),
      ),
      bottomNavigationBar: ButtomNavigationBar('recycle'),
    );
  }
}