import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:convert';

import '../scoped_models/main.dart';
import '../models/user.dart';

import '../widgets/custom_text.dart' as customText;

import './profile_edit.dart';
import './profile_pic_view.dart';

class ProfilePage extends StatelessWidget {
  Container _buildProfile(BuildContext context, MainModel model) {
    print(json.encode(model.client.toMap()));
    return Container(
      margin: EdgeInsets.symmetric(vertical: 36, horizontal: 18),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 18),
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ProfilePicViewPage()
                ));
              },
              child: Hero(
                tag: 'profile_pic',
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 70,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 18),
            child: Column(
              children: <Widget>[
                customText.HeadlineText(
                  text: model.client.name,
                  textColor: Theme.of(context).primaryColor,
                ),
                // Container(
                //   padding:
                //       EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                //   margin: EdgeInsets.symmetric(
                //     vertical: 7,
                //   ),
                //   decoration: BoxDecoration(
                //       color: Theme.of(context).primaryColor,
                //       borderRadius: BorderRadius.circular(10)),
                //   child: Text(
                //     'Verified',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
                // Text('Last Login: 1min'),
                /*Row(
                children: <Widget>[
                  Text('250,000')
                ],
              )*/
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 18),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('email'),
                  subtitle: Text(model.user.email),
                ),
                Divider(),
                ListTile(
                  title: Text('phone number'),
                  subtitle: Text(model.client.phone),
                ),
                Divider(),
                ListTile(
                  title: Text('account type'),
                  subtitle: Text('Individual'),
                ),
                Divider(),
                ListTile(
                  title: Text('location'),
                  subtitle: model.client.address == 'null' ? Text('No Address',
                  style: TextStyle(color: Colors.red),) : Text(model.client.address),
                ),
                Divider(),
                // ListTile(
                //   title: Text('Simple Ads'),
                //   subtitle: Text('Unlimited'),
                // ),
                // Divider(),
                ListTile(
                  title: Text('Featured Ads'),
                  subtitle: Text('Unlimited'),
                ),
                Divider(),
                ListTile(
                  title: Text('Expiration Date'),
                  subtitle: Text('None'),
                ),
                Divider(),
                ListTile(
                  title: Text('3.493.939'),
                  subtitle: Text('Unlimited'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    void _pushRoute(route) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return route;
      }));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _pushRoute(ProfileEditPage());
            },
          )
        ],
      ),
      body: Container(
        width: deviceWidth,
        child: SingleChildScrollView(
          child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model){
              return _buildProfile(context, model);
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        foregroundColor: Colors.white,
        onPressed: () {},
      ),
    );
  }
}
