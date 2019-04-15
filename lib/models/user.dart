import 'package:flutter/material.dart';

class Client{
  final String id;
  final String token;
  final String phone;
  final String email;
  final String username;

  Client({
    @required this.id, 
    @required this.token,
    @required this.phone,
    @required this.email,
    @required this.username,
  });
}