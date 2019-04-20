import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/dispose_waste.dart';
import '../pages/recycle_waste.dart';
import '../pages/decluster/decluster.dart';


class BottomNav extends StatelessWidget{
  final int index;
  final List _routes = [HomePage(), DisposeWastePage(), RecycleWastePage(), DeclusterPage(), HomePage()];

  BottomNav(this.index);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      // type: BottomNavigationBarType.shifting,
      onTap: (int idx){
        if(idx == index) return;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => _routes[idx]
          ),
          (Route route) => false
        );
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          backgroundColor: Colors.green,
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete,),
          backgroundColor: Colors.green,
          title: Text('Dispose'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync,),
          backgroundColor: Colors.green,
          title: Text('Recycle'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.zoom_out_map,),
          backgroundColor: Colors.green,
          title: Text('Decluster'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info,),
          backgroundColor: Colors.green,
          title: Text('Info'),
        ),
      ],
    );
  }
}
