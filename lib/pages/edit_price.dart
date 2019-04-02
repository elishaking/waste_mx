import 'package:flutter/material.dart';

class EditPricePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EditPricePageState();
  }
}

class _EditPricePageState extends State<EditPricePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Price'),
      ),
      body: Container(
        child: Center(child: Text('Edit Price'),),
      ),
    );
  }
}