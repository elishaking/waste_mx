import 'package:flutter/material.dart';

class CategoryListPage extends StatelessWidget{
  final String categoryName;
  final List<String> categories;

  CategoryListPage(this.categoryName, this.categories);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.categoryName)
      ),
      body: ListView(
        children: List.generate(categories.length, (int index) => ListTile(
          title: Text(categories[index]),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: (){
            
          },
        )),
      ),
    );
  }
}