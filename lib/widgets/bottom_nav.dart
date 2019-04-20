import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/dispose_waste.dart';
import '../pages/recycle_waste.dart';
import '../pages/decluster/decluster.dart';


class BottomNav extends StatelessWidget{
  final int index;
  final List _routes = [HomePage(), DisposeWastePage(), RecycleWastePage(), DeclusterPage()];

  BottomNav(this.index);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      // type: BottomNavigationBarType.shifting,
      onTap: (int idx){
        if(idx == index) return;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => _routes[idx]
          )
        );
      },

      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home,),
          backgroundColor: Colors.green.shade300,
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.delete,),
          title: Text('Dispose'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.sync,),
          title: Text('Recycle'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.zoom_out_map,),
          title: Text('Decluster'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info,),
          title: Text('Info'),
        ),
      ],
    );
  }
}
