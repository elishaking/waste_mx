import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scoped_models/main.dart';

class SubCategoryViewPage extends StatefulWidget{
  final String subCategoryName;

  SubCategoryViewPage(this.subCategoryName);

  @override
  _SubCategoryViewPageState createState() => _SubCategoryViewPageState();
}

class _SubCategoryViewPageState extends State<SubCategoryViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subCategoryName),
      ),
      body: ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model){
          return model.isLoading ? Center(
            child: CircularProgressIndicator(),
          ) : ListView(
            children: <Widget>[],
          );
        },
      ),
    );
  }
}