import 'package:flutter/material.dart';

import './pages/login.dart';
import './pages/signup.dart';
import './pages/home.dart';
import './pages/search.dart';

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
      home: HomePage(),
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'signup': (BuildContext context) => SignUpPage(),
        'home': (BuildContext context) => HomePage(),
        'search': (BuildContext context) => SearchPage()
      }
    );
  }
}
