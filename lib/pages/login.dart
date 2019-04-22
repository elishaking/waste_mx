import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main.dart';
import '../models/user.dart';

class LoginPage extends StatefulWidget {
  final UserType userType;

  LoginPage(this.userType);

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> _formData = {'email': '', 'password': ''};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  Widget _buildSocialMediaLogin() {
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
            child: Image.asset(
              'assets/facebook.png',
              scale: 1.7,
            ),
            onPressed: () {},
          ),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Image.asset(
              'assets/google.png',
              scale: 1.7,
            ),
            onPressed: () {},
          ),
          OutlineButton(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(1000),
            ),
            child: Image.asset(
              'assets/twitter.png',
              scale: 1.7,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(MainModel model) {
    return RaisedButton(
      textColor: Colors.white,
      child: Text('Login'),
      onPressed: () {
        // if(_formKey.currentState.validate()){
        _formKey.currentState.save();
        if (widget.userType == UserType.Client) {
          _loginUser(model, UserType.Client, 'home');
        } else {
          _loginUser(model, UserType.Vendor, 'vendor_home');
        }
        // }
      },
    );
  }

  void _loginUser(MainModel model, UserType userType, String route) {
    model.login(_formData['email'], _formData['password'], userType).then((data) {
      if (data['success']) {
        Navigator.of(context).pushNamedAndRemoveUntil(route, (Route route) => false);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('An Error Ocurred'),
              content: Text(data['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                _buildErrorDialogActionButton(data['code'])
              ],
            );
          });
      }
    });
  }

  Widget _buildErrorDialogActionButton(int code) {
    if (code == 0) {
      return FlatButton(
        child: Text('SIGN UP'),
        onPressed: () {
          Navigator.pop(context, () {
            Navigator.pushReplacementNamed(context, 'signup');
          });
        },
      );
    } else if (code == 1) {
      return FlatButton(
        child: Text('RESET PASSWORD'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } else if (code == 2) {
      return FlatButton(
        child: Text('REVIEW'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      return Container();
    }
  }

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
              Text(
                'Login With',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              _buildSocialMediaLogin(),
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
                                borderRadius: BorderRadius.circular(10))),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your email is required';
                          } else if (!RegExp(r'^[a-z]+@[a-z]+\.[a-z]+$')
                              .hasMatch(value.toLowerCase())) {
                            return 'Please enter a valid email';
                          }
                        },
                        onSaved: (String value) {
                          _formData['email'] = value;
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.remove_red_eye),
                            onTap: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: showPassword,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Your password is required';
                          }
                        },
                        onSaved: (String value) {
                          _formData['password'] = value;
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          child: Text('Forgot Password'),
                          onPressed: () {},
                        ),
                      ),
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child,
                            MainModel model) {
                          return model.isLoading
                              ? CircularProgressIndicator()
                              : _buildSubmitButton(model);
                          // return  RaisedButton(
                          //   textColor: Colors.white,
                          //   child: Text('Login'),
                          //   onPressed: (){
                          //     Navigator.pushReplacementNamed(context, widget.role == 'user' ? 'home' : 'vendor_home');
                          //   },
                          // );
                        },
                      ),
                      FlatButton(
                        child: Text("Don't have an account, Sign Up"),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, 'signup', (Route route) => false);
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
