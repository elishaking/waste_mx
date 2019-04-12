import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_models/main.dart';

import './pages/welcome.dart';
import './pages/login.dart';
import './pages/signup.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/profile.dart';
import './pages/dispose_waste.dart';
import './pages/vendor_home.dart';
import './pages/offerings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: MaterialApp(
        title: 'Waste MX',
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.amber,
          buttonColor: Colors.amber,
          fontFamily: 'Lato',
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.amber,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        ),
        color: Colors.green,
        home: OfferingsPage(),
        routes: {
          // 'login': (BuildContext context) => LoginPage(),
          'signup': (BuildContext context) => SignUpPage('user'),
          'home': (BuildContext context) => HomePage(),
          'vendor_home': (BuildContext context) => VendorHomePage(),
          'search': (BuildContext context) => SearchPage(),
          'profile': (BuildContext context) => ProfilePage(),
          'dispose_waste': (BuildContext context) => DisposeWastePage(),
        }
      ),
    );
  }
}
