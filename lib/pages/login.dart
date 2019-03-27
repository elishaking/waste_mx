import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{
  final Map<String, dynamic> _formData = {
    'email': '',
    'password': ''
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = false;

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
                        keyboardType: TextInputType.emailAddress,
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
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            suffixIcon: GestureDetector(
                              child: Icon(Icons.remove_red_eye),
                              onTap: (){
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                        ),
                        obscureText: showPassword,
                        validator: (String value) {
                          if(value.isEmpty){
                            return 'Your password is required';
                          }
                        },
                        onSaved: (String value){
                          _formData['password'] = value;
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
                          if(_formKey.currentState.validate()){
                            _formKey.currentState.save();
                            Navigator.pushReplacementNamed(context, 'home');
                          }
                        },
                      ),
                      FlatButton(
                        child: Text("Don't have an account, Sign Up"),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'signup');
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