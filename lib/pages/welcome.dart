import 'package:flutter/material.dart';

import './onboarding.dart';

import '../widgets/custom_text.dart' as customText;

class WelcomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context){
              return OnboardingPage();
            }
          ));
        },
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.only(top: 50, bottom: 18, left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Image(
                        height: 70,
                        image: AssetImage('assets/logo.png')
                    ),
                  ),
                  customText.TitleText(
                    text: 'Waste MX',
                    textColor: Theme.of(context).accentColor,
                  )
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(70),
                      child: Image(image: AssetImage('assets/welcome-img.png')),
                    ),
                    customText.TitleText(
                      text: 'Make money with waste',
                      textColor: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
              customText.BodyText(
                text: 'TAP ANYWHERE TO CONTINUE',
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}