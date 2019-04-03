import 'package:flutter/material.dart';

import '../widgets/custom_text.dart' as customText;

import './signup.dart';

class SelectRolePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SelectRolePageState();
  }
}

class _SelectRolePageState extends State<SelectRolePage>{
  bool _userSelected = false;
  bool _vendorSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,),
          child: Image(image: AssetImage('assets/logo.png')),
        ),
        title: Text('Waste MX'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: customText.TitleText(
                  text: 'How would you like to use Waste MX',
                  textColor: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              ListTile(
                title: Text('Continue as User'),
                subtitle: Text('Request for Vendor (waste collector)'),
                selected: _userSelected,
                onTap: (){
                  setState(() {
                    _userSelected = true;
                    _vendorSelected = false;
                  });
                },
              ),
              Divider(),
              ListTile(
                title: Text('Continue as Vendor'),
                subtitle: Text('Collect and recycle waste'),
                selected: _vendorSelected,
                onTap: (){
                  setState(() {
                    _vendorSelected = true;
                    _userSelected = false;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  child: Text('Next'),
                  textColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SignUpPage(_userSelected ? 'user' : 'vendor')
                    ));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}