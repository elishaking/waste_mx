import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import '../widgets/custom_text.dart' as customText;

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final double _textInputBorderRadius = 10;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'name': '',
    'phone': '',
    'email': '',
    'location': ''
  };

  Form _buildForm(BuildContext context, MainModel model) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'full name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_textInputBorderRadius)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Your full name is required';
              }
            },
            onSaved: (String value) {
              _formData['name'] = value;
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'phone',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_textInputBorderRadius)),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Your phone number is required';
              } else if (!RegExp(r'^[0-9]+$')
                  .hasMatch(value.toLowerCase())) {
                return 'Please enter a valid phone number';
              }
            },
            onSaved: (String value) {
              _formData['phone'] = value;
            },
          ),
          SizedBox(height: 20,),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.person_outline),
              labelText: 'location',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(_textInputBorderRadius)),
            ),
            validator: (String value) {
              
            },
            onSaved: (String value) {
              _formData['location'] = value;
            },
          ),
          SizedBox(height: 20,),
          RaisedButton(
            child: customText.BodyText(text: 'SAVE', textColor: Colors.white,),
            onPressed: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                model.updateUser(_formData, 'clients').then((done){
                  Navigator.pop(context);
                });
              }
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
        title: Text('Edit Profile'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: SingleChildScrollView(
          child: ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model){
              return model.isLoading ? CircularProgressIndicator() : _buildForm(context, model);
            },
          ),
        )
      ),
    );
  }
}
