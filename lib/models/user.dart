import 'package:flutter/material.dart';

class User{
  final String id;
  final String phone;
  final String email;
  final String username;
  final String password;

  User({
    @required this.id, 
    @required this.phone,
    @required this.email,
    @required this.username,
    @required this.password,
  });
}