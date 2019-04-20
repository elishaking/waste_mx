import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart' as customText;

class InfoPage extends StatefulWidget{
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates'),
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                padding: EdgeInsets.only(bottom: 20),
                color: Theme.of(context).primaryColor,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        customText.TitleText(text: 'Streak', textColor: Theme.of(context).accentColor,),
                        customText.HeadlineText(
                          text: '30',
                          fontSize: 100,
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        customText.TitleText(text: 'Transactions', textColor: Theme.of(context).accentColor,),
                        customText.HeadlineText(
                          text: '20',
                          fontSize: 100,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}