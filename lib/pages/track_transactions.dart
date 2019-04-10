import 'package:flutter/material.dart';

class TrackTransactionsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final transactions = [

    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Track Transactions'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        child: ListView(
          children: List.generate(transactions.length, (index) => Card(
            child: Column(

            ),
          )),
        ),
      ),
    );
  }
}