import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart' as customText;
import '../../widgets/bottom_nav.dart';

class InfoPage extends StatefulWidget{
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Earned Coins',
      'message':
          'You earned 50 points just for installation, check your wallet',
      'action': 'WALLET'
    },
  ];

  Widget _buildMessagesSection() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: List.generate(
          _messages.length,
          (int index) => Card(
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 15
              ),
              color: Colors.green.withOpacity(0.05),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(_messages[index]['icon']),
                    title: Text(_messages[index]['title']),
                    subtitle: Text(_messages[index]['message']),
                  ),
                  ButtonTheme.bar(
                    child: ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          child: Text(_messages[index]['action']),
                          onPressed: () {},
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
      ),
    );
  }

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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Theme.of(context).primaryColor,
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).primaryColor,
                      Colors.green.shade700
                    ]
                  )
                ),
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
              ),
              SizedBox(height: 25,),
              _buildMessagesSection()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(4),
    );
  }
}