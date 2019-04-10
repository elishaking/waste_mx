import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';

import './login.dart';

class SignUpPage extends StatefulWidget{
  final String role;

  SignUpPage(this.role);

  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
    'phone': '',
    'email': '',
    'username': '',
    'password': ''
  };

  bool showPassword1 = true;
  bool showPassword2 = true;

  TextEditingController _passwordController = TextEditingController();

  Widget _buildSocialMediaLogin(){
    return Container(
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
    );
  }

  // Widget _buildEmailField(){
  //   return 
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 18),
                child: Text(
                  'Sign up With',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                  ),
                ),
              ),
              _buildSocialMediaLogin(),
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'phone',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your phone number is required';
                          } else if(!RegExp(r'^[0-9]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid phone number';
                          }
                        },
                        onSaved: (String value){
                          _formData['phone'] = value;
                        },
                      ),
                      SizedBox(height: 25,),
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
                        onSaved: (String value){
                          _formData['email'] = value;
                        },
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your username is required';
                          }
                          /*else if(!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$').hasMatch(value.toLowerCase())){
                            return 'Please enter a valid username';
                          }*/
                        },
                        onSaved: (String value){
                          _formData['username'] = value;
                        },
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: (){
                              setState(() {
                                showPassword1 = !showPassword1;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword1,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your password is required';
                          }
                        },
                        onSaved: (String value){
                          _formData['password'] = value;
                        },
                      ),
                      SizedBox(height: 25,),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'confirm password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: (){
                              setState(() {
                                showPassword2 = !showPassword2;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword2,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Re-enter your password';
                          } else if(value != _passwordController.text){
                            return "Passwords don't match";
                          }
                        },
                      ),
                      SizedBox(height: 25,),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child, MainModel model){
                          return RaisedButton(
                            textColor: Colors.white,
                            child: Text('Sign Up'),
                            onPressed: (){
                              // if(_formKey.currentState.validate()){
                                _formKey.currentState.save();
                                if(widget.role == 'user'){
                                  model.signup(_formData['email'], _formData['password']).then((data) {
                                    if(data['success']){
                                      Navigator.pushReplacementNamed(context, 'home');
                                    }
                                  });
                                } else{
                                  Navigator.popAndPushNamed(context, 'vendor_home');
                                }
                              // }
                            },
                          );
                        },
                      ),
                      FlatButton(
                        child: Text("Already have an account, Login"),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage(widget.role)
                          ));
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