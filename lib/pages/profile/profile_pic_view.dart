import 'package:flutter/material.dart';

class ProfilePicViewPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              
            },
          )
        ],
      ),
      body: Center(
        child: Hero(
          tag: 'profile_pic',
          child: Image(
            width: MediaQuery.of(context).size.width,
            image: AssetImage('assets/profile.png'),
          ),
        ),
      ),
    );
  }
}