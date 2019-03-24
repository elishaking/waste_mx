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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Login With', style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),),
              Container(
                padding: EdgeInsets.symmetric(vertical: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    OutlineButton(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset('assets/facebook.png', scale: 1.7,),
                      onPressed: () {

                      },
                    ),
                    OutlineButton(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset('assets/google.png', scale: 1.7,),
                      onPressed: () {

                      },
                    ),
                    OutlineButton(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      child: Image.asset('assets/twitter.png', scale: 1.7,),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your email is required';
                          } else if(!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid email';
                          }
                        },
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
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
                        textColor: Colors.white,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}