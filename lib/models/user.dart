import 'package:flutter/material.dart';

enum UserType{
  Client,
  Vendor
}
class User{
  final String id;
  final String token;
  // final String phone;
  final String email;
  final UserType userType;
  // final String username;

  User({
    @required this.id, 
    @required this.token,
    // @required this.phone,
    @required this.email,
    // @required this.username,
    @required this.userType,
  });
}

class Client{

}

class Vendor{

}