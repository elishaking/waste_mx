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
  final String id;
  final String name;
  final String phone;
  final String username;
  final String address;
  final DateTime dateCreated;

  Client({this.id, this.name, this.phone, this.username, this.address, this.dateCreated});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'username': username,
      'address': address,
      'dateCreated': dateCreated,
    };
  }
}

class Vendor{
  final String id;
  final String name;
  final String companyName;
  final String companyAddress;
  final String phone;
  final String username;
  final String address;
  final DateTime dateCreated;

  Vendor({this.id, this.name, this.companyName, this.companyAddress, this.phone, this.username, this.address, this.dateCreated});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'username': username,
      'address': address,
      'companyName': companyName,
      'companyAddress': companyAddress,
      'dateCreated': dateCreated,
    };
  }
}