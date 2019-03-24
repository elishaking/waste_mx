import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'email'
                    ),
                    validator: (String value) {
                      if(value.isEmpty){
                        return 'Your email is required';
                      } else if(!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$').hasMatch(value.toLowerCase())){
                        return 'Please enter a valid email';
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}