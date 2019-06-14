import 'package:flutter/material.dart';

import '../utils/responsive.dart';

import '../pages/home.dart';
import '../pages/dispose/dispose_waste.dart';
import '../pages/recycle/recycle_waste.dart';

class ButtomNavigationBar extends StatelessWidget {
  final String page;

  ButtomNavigationBar(this.page);

  Widget _buildPageSelected(
      BuildContext context, IconData iconData, String title) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: Theme.of(context).accentColor,
        ),
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontSize: getSize(context, 11),
          ),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  void _pushRoute(context, route) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return route;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getSize(context, 3)),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5))),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: page == 'home'
                  ? _buildPageSelected(context, Icons.home, 'Home')
                  : Icon(Icons.home),
              onPressed: () {
                if (page != 'home') {
                  _pushRoute(context, HomePage());
                }
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: page == 'dispose'
                  ? _buildPageSelected(context, Icons.delete, 'Dispose')
                  : Icon(Icons.delete),
              onPressed: () {
                if (page != 'dispose') {
                  _pushRoute(context, DisposeWastePage());
                }
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: page == 'recycle'
                  ? _buildPageSelected(context, Icons.sync, 'Recycle')
                  : Icon(Icons.sync),
              onPressed: () {
                if (page != 'recycle') {
                  _pushRoute(context, RecycleWastePage());
                }
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: page == 'decluster'
                  ? _buildPageSelected(context, Icons.zoom_out_map, 'decluster')
                  : Icon(Icons.zoom_out_map),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FlatButton(
              child: page == 'sewage'
                  ? _buildPageSelected(context, Icons.delete_forever, 'Sewage')
                  : Icon(Icons.delete_forever),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
