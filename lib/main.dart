import 'package:flutter/material.dart';

import './pages/welcome.dart';
// import './pages/login.dart';
// import './pages/signup.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/profile.dart';
import './pages/dispose_waste.dart';
import './pages/vendor_home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waste MX',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        buttonColor: Colors.amber,
        fontFamily: 'Lato',
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
      color: Colors.green,
      home: HomePage(),
      routes: {
        // 'login': (BuildContext context) => LoginPage(),
        // 'signup': (BuildContext context) => SignUpPage(),
        'home': (BuildContext context) => HomePage(),
        'vendor_home': (BuildContext context) => VendorHomePage(),
        'search': (BuildContext context) => SearchPage(),
        'profile': (BuildContext context) => ProfilePage(),
        'dispose_waste': (BuildContext context) => DisposeWastePage(),
      }
    );
  }
}
