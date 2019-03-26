import 'package:flutter/material.dart';

import './pages/login.dart';
import './pages/signup.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/profile.dart';
import './pages/dispose_waste.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        buttonColor: Colors.amber,
        fontFamily: 'Lato'
      ),
      home: DisposeWastePage(),
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'signup': (BuildContext context) => SignUpPage(),
        'home': (BuildContext context) => HomePage(),
        'search': (BuildContext context) => SearchPage(),
        'profile': (BuildContext context) => ProfilePage(),
        'dispose_waste': (BuildContext context) => DisposeWastePage(),
      }
    );
  }
}
