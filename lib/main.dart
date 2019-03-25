import 'package:flutter/material.dart';

import './pages/login.dart';
import './pages/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.yellow,
        buttonColor: Colors.amber,
        fontFamily: 'Lato'
      ),
      home: LoginPage(),
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'signup': (BuildContext context) => SignUpPage(),
      }
    );
  }
}
