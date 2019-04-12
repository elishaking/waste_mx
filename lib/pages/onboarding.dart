import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as custom_text;

import './select_role.dart';

class OnboardingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OnboardingPageState();
  }
}

class _OnboardingPageState extends State<OnboardingPage>{
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
      'body': 'User can initiate waste pickup by publishing waste bags to waste collectors',
    },
    {
      'imageUrl': 'assets/obd-2.png',
      'title': 'Waste Collector',
      'body': 'Waste collector accept users offer for pickup. Can post rate and location of pickup',
    },
    {
      'imageUrl': 'assets/obd-3.png',
      'title': 'Recycling',
      'body': 'User can either call/request recycling collectors. User can make/accept offer for pickup',
    },
    {
      'imageUrl': 'assets/obd-4.png',
      'title': 'Earning Points',
      'body': 'Users will earn 10 points whenever a transaction is completed',
    },
  ];

  Widget _buildOnboardingTab({int pos}){
    return Expanded(
      child: Container(
        height: 5,
        color: pos <= _tabPos ? Colors.white : Colors.white30,
        margin: EdgeInsets.symmetric(horizontal: 2),
      ),
    );
  }

  void _navPush(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => SelectRolePage()
    ));
  }

  @override
  Widget build(BuildContext context) {
    final int _maxTabs = 5;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          if(_tabPos < 5){
            setState(() {
              _tabPos++;
            });
          } else if(_tabPos == 5){
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
                      icon: Icon(Icons.arrow_back, color: Colors.white,),
                      onPressed: (){
                        if(_tabPos > 1){
                          setState(() {
                            _tabPos--;
                          });
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
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(_infoList[_tabPos - 1]['imageUrl']),
                        SizedBox(height: 10),
                        custom_text.TitleText(text: _infoList[_tabPos - 1]['title'],),
                        custom_text.BodyText(
                          text: _infoList[_tabPos - 1]['body'],
                          textAlign: TextAlign.center,
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              Text('TAP ANYWHERE TO CONTINUE', style: TextStyle(color: Colors.white),)
            ],
          ),
        ),
      ),
    );
  }
}