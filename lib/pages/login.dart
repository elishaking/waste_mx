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
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Sign In With'),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.face),
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: Icon(Icons.face),
                  onPressed: () {

                  },
                ),
                IconButton(
                  icon: Icon(Icons.face),
                  onPressed: () {

                  },
                ),
              ],
            ),
            Form(
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
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'password'
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your email is required';
                          } else if(!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid email';
                          }
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text('Forgot Password'),
                          onPressed: () {

                          },
                        ),
                      ),
                      RaisedButton(
                        child: Text('Login'),
                        onPressed: (){

                        },
                      ),
                      FlatButton(
                        child: Text("Don't have an account, Sign Up"),
                        onPressed: () {

                        },
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}