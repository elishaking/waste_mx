import 'package:flutter/material.dart';

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
        buttonColor: Colors.yellow,
        fontFamily: 'Lato'
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Waste MX'),
        ),
        body: Center(
          child: Text('Waste MX'),
        ),
      ),
    );
  }
}
