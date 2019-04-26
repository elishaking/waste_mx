import 'package:flutter/material.dart';

class SubCategoryListPage extends StatelessWidget{
  final String categoryName;
  final List<String> categories;

  SubCategoryListPage(this.categoryName, this.categories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.categoryName)
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        children: List.generate(categories.length, (int index) => _buildSubCategory(index)),
      ),
    );
  }

  Column _buildSubCategory(int index) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(categories[index]),
          trailing: Icon(Icons.arrow_forward_ios, size: 17,),
          onTap: (){
            
          },
        ),
        Divider()
      ],
    );
  }
}