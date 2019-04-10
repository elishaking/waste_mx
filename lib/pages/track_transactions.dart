import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './home.dart';

class TrackTransactionsPage extends StatelessWidget{
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

  Widget _buildStatus(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: transactions[index]['pending'] ? <Widget>[
          Icon(Icons.sync_problem, color: Colors.deepOrange,),
          SizedBox(width: 10,),
          customText.BodyText(
            text: 'Pending',
            textColor: Colors.deepOrange,
          ),
        ] : <Widget>[
          Icon(Icons.check_circle, color: Colors.green,),
          SizedBox(width: 10,),
          customText.BodyText(
            text: 'Complete',
            textColor: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(int index){
    return ButtonTheme.bar(
      child: ButtonBar(
        children: <Widget>[
          transactions[index]['pending'] ? FlatButton(
            child: customText.BodyText(
              text: 'Complete',
              textColor: Colors.green,
            ),
            onPressed: (){

            },
          ) : FlatButton(
            child: customText.BodyText(
              text: 'Delete',
              textColor: Colors.deepOrange,
            ),
            onPressed: (){

            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Transactions'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => HomePage()
            ));
          },)
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: ListView(
          children: List.generate(transactions.length, (int index) => Card(
            child: Column(
              children: <Widget>[
                _buildStatus(index),
                ListTile(
                  leading: CircleAvatar(
                    child: Image(image: AssetImage('assets/profile.png'),),
                  ),
                  title: Text(transactions[index]['type']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(transactions[index]['vendor']),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: customText.BodyText(
                          text: 'NGN ${transactions[index]['amount'].toString()}',
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                _buildActionButtons(index)
              ],
            ),
          )),
        ),
      ),
    );
  }
}