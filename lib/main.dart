import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './models/user.dart';
import './scoped_models/main.dart';

import './pages/welcome.dart';
// import './pages/login.dart';
import './pages/signup.dart';
import './pages/home.dart';
import './pages/search.dart';
import './pages/profile.dart';
import './pages/dispose_waste.dart';
// import './pages/recycle_waste.dart';
import './pages/vendor/vendor_home.dart';
// import './pages/vendor/offerings.dart';
import './pages/book_vendor.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthenticate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: _model,
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
        home: WelcomePage(),
        routes: {
          // '/': (BuildContext context) => ScopedModelDescendant(
          //   builder: (BuildContext context, Widget child, MainModel model){
          //     return model.user == null ? WelcomePage() : (model.user.userType == UserType.Client ? HomePage() : VendorHomePage());
          //   },
          // ),
          // '/': (BuildContext context) => BookVendorPage(),
          // 'login': (BuildContext context) => LoginPage(),
          'welcome': (BuildContext context) => WelcomePage(),
          // 'signup': (BuildContext context) => SignUpPage('user'),
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
