import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './home.dart';

class TrackTransactionsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrackTransactionsPageState();
  }
}

class _TrackTransactionsPageState extends State<TrackTransactionsPage> {
  final transactions = [
    {
      'pending': true,
      'type': 'Household Waste',
      'vendor': 'Json Martinz Partners',
      'amount': 1000,
    },
    {
      'pending': false,
      'type': 'Office Waste',
      'vendor': 'Json Martinz Bilikizzz',
      'amount': 3000,
    },
    {
      'pending': true,
      'type': 'Household Waste',
      'vendor': 'Json Martinz Partners',
      'amount': 1000,
    },
  ];

  double _targetWidth = 0;

  double _getSize(final double default_1440) {
    return (default_1440 / 14) * (0.0027 * _targetWidth + 10.136);
  }

  Widget _buildStatus(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: transactions[index]['pending']
            ? <Widget>[
                Icon(
                  Icons.sync_problem,
                  color: Colors.deepOrange,
                  size: _getSize(23),
                ),
                SizedBox(
                  width: 10,
                ),
                customText.BodyText(
                  text: 'Pending',
                  textColor: Colors.deepOrange,
                ),
              ]
            : <Widget>[
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: _getSize(23),
                ),
                SizedBox(
                  width: 10,
                ),
                customText.BodyText(
                  text: 'Complete',
                  textColor: Colors.green,
                ),
              ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, int index) {
    return ButtonTheme.bar(
      child: ButtonBar(
          children: transactions[index]['pending']
              ? [
                  // FlatButton(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.chat_bubble_outline,
                  //         color: Theme.of(context).primaryColor,
                  //         size: _getSize(23),
                  //       ),
                  //       SizedBox(
                  //         width: _getSize(10),
                  //       ),
                  //       customText.BodyText(
                  //         text: 'CHAT',
                  //         textColor: Theme.of(context).primaryColor,
                  //       )
                  //     ],
                  //   ),
                  //   onPressed: () {},
                  // ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.call,
                          color: Theme.of(context).primaryColor,
                          size: _getSize(23),
                        ),
                        SizedBox(
                          width: _getSize(10),
                        ),
                        customText.BodyText(
                          text: 'CALL',
                          textColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye,
                          color: Theme.of(context).primaryColor,
                          size: _getSize(23),
                        ),
                        SizedBox(
                          width: _getSize(10),
                        ),
                        customText.BodyText(
                          text: 'VIEW',
                          textColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                  // FlatButton(
                  //   child: Row(
                  //     children: <Widget>[
                  //       Icon(
                  //         Icons.done_all,
                  //         color: Theme.of(context).primaryColor,
                  //         size: _getSize(23),
                  //       ),
                  //       SizedBox(
                  //         width: _getSize(10),
                  //       ),
                  //       customText.BodyText(
                  //         text: 'COMPLETE',
                  //         textColor: Theme.of(context).primaryColor,
                  //       )
                  //     ],
                  //   ),
                  //   onPressed: () {},
                  // ),
                ]
              : [
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.delete_forever,
                          color: Colors.deepOrange,
                          size: _getSize(23),
                        ),
                        SizedBox(
                          width: _getSize(10),
                        ),
                        customText.BodyText(
                          text: 'DELETE',
                          textColor: Colors.deepOrange,
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye,
                          color: Theme.of(context).primaryColor,
                          size: _getSize(23),
                        ),
                        SizedBox(
                          width: _getSize(10),
                        ),
                        customText.BodyText(
                          text: 'VIEW',
                          textColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                    onPressed: () {},
                  ),
                ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    _targetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Transactions'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: ListView(
          children: List.generate(
              transactions.length,
              (int index) => Card(
                    child: Column(
                      children: <Widget>[
                        _buildStatus(index),
                        ListTile(
                          leading: CircleAvatar(
                            child: Image(
                              image: AssetImage('assets/profile.png'),
                            ),
                          ),
                          title: Text(transactions[index]['type']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(transactions[index]['vendor']),
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(100)),
                                child: customText.BodyText(
                                  text:
                                      'NGN ${transactions[index]['amount'].toString()}',
                                  textColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        _buildActionButtons(context, index)
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
