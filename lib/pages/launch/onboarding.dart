import 'package:flutter/material.dart';
import 'package:waste_mx/utils/responsive.dart';

import '../../widgets/custom_text.dart' as custom_text;

import '../auth/select_role.dart';

class OnboardingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnboardingPageState();
  }
}

class _OnboardingPageState extends State<OnboardingPage> with TickerProviderStateMixin{
  int _tabPos = 1;
  List<Map<String, String>> _infoList = [
    {
      'imageUrl': 'assets/intro.png',
      'title': 'How Waste MX works',
      'body': "Let's quickly review how you can use Waste MX",
    },
    {
      'imageUrl': 'assets/obd-1.png',
      'title': 'User',
      'body':
          'User can initiate waste pickup by publishing waste bags to waste collectors',
    },
    {
      'imageUrl': 'assets/obd-2.png',
      'title': 'Waste Collector',
      'body':
          'Waste collector accept users offer for pickup. Can post rate and location of pickup',
    },
    {
      'imageUrl': 'assets/obd-3.png',
      'title': 'Recycling',
      'body':
          'User can either call/request recycling collectors. User can make/accept offer for pickup',
    },
    {
      'imageUrl': 'assets/obd-4.png',
      'title': 'Earning Points',
      'body': 'Users will earn 10 points whenever a transaction is completed',
    },
  ];

  List<AnimationController> _controllers = List();

  @override
  void initState(){
    for(int i = 0; i < _infoList.length; i++){
      _controllers.add(AnimationController(vsync: this, duration: Duration(milliseconds: 300)));
    }
    _controllers[0].forward();
    super.initState();
  }

  double _getOpacity(double value){
    return value < 0.2 ? 0.2 : value;
  }

  Widget _buildOnboardingTab({int pos}) {
    return Expanded(
      child: AnimatedBuilder(
        animation: _controllers[pos - 1],
        builder: (BuildContext context, Widget child){
          return Container(
            height: 5,
            color: Colors.white.withOpacity(_getOpacity(_controllers[pos - 1].value)),
            margin: EdgeInsets.symmetric(horizontal: 2),
          );
        },
      ),
    );
  }

  void _navPush(BuildContext context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => SelectRolePage()));
  }

  @override
  Widget build(BuildContext context) {
    final int _maxTabs = 5;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          if (_tabPos < 5) {
            _controllers[_tabPos - 1].reverse();
            _controllers[_tabPos].forward();
            _tabPos++;
            // setState(() {
            //   _tabPos++;
            // });
          } else if (_tabPos == 5) {
            _navPush(context);
          }
        },
        child: Container(
          padding: EdgeInsets.only(top: 50, bottom: 18, left: 10, right: 10),
          color: Theme.of(context).primaryColor,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _buildOnboardingTab(pos: 1),
                  _buildOnboardingTab(pos: 2),
                  _buildOnboardingTab(pos: 3),
                  _buildOnboardingTab(pos: 4),
                  _buildOnboardingTab(pos: 5),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (_tabPos > 1) {
                          // setState(() {
                          //   _tabPos--;
                          // });
                          _tabPos--;
                          _controllers[_tabPos - 1].forward();
                          _controllers[_tabPos].reverse();
                        } else{
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                    FlatButton(
                      child: Text('SKIP'),
                      textColor: Colors.white,
                      onPressed: () => _navPush(context),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: List.generate(_infoList.length, (int index) => ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _controllers[index],
                        curve: Interval(0, 1, curve: Curves.easeOut)
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image(
                                image: AssetImage(_infoList[index]['imageUrl']),
                                height: getSize(context, 400),
                              ),
                              SizedBox(height: getSize(context, 30)),
                              custom_text.TitleText(
                                text: _infoList[index]['title'],
                              ),
                              SizedBox(height: 5,),
                              custom_text.BodyText(
                                text: _infoList[index]['body'],
                                textAlign: TextAlign.center,
                                textOverflow: TextOverflow.clip,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                ),
              ),
              Text(
                'TAP ANYWHERE TO CONTINUE',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
