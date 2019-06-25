import 'package:flutter/material.dart';

enum UserType { Client, Vendor }

class User {
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

  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'userEmail': email,
      'userUserType': userType.toString(),
      'userToken': token,
    };
  }
}

class Client {
  String id;
  String name;
  String phone;
  List<double> pos;
  String username;
  String address;
  String dateCreated;
  String subAccountCode;

  Client({this.id, this.name, this.phone, this.pos, this.username, this.address,
    this.dateCreated, this.subAccountCode});

  void update({String name, String phone, List<double> pos, String username, String address}){
    this.name = name ?? this.name;
    this.phone = phone ?? this.phone;
    this.pos = pos ?? this.pos;
    this.username = username ?? this.username;
    this.address = address ?? this.address;
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': id,
      'clientName': name,
      'clientPhone': phone,
      'clientUsername': username,
      'clientAddress': address,
      'clientDateCreated': dateCreated,
      'clientSubAccountCode': subAccountCode
    };
  }
}

class Vendor {
  String id;
  String name;
  String imageUrl;
  List<double> pos;
  String companyName;
  String companyAddress;
  String phone;
  String username;
  String address;
  String dateCreated;
  int rating;
  int rate;
  bool verified;
  double distance;
  String subAccountCode;

  Vendor({this.id, this.name, this.imageUrl, this.pos, this.companyName, this.companyAddress, this.phone,
    this.username, this.address, this.dateCreated, this.rating, this.rate, this.verified, this.distance,
    this.subAccountCode});

  void update({String name, String phone, List<double> pos, String username, String address, String companyName, String companyAddress, int rating, int rate, double distance}){
    this.name = name ?? this.name;
    this.phone = phone ?? this.phone;
    this.pos = pos ?? this.pos;
    this.username = username ?? this.username;
    this.address = address ?? this.address;
    this.companyName = companyName ?? this.companyName;
    this.companyAddress = companyAddress ?? this.companyAddress;
    this.rating = rating ?? this.rating;
    this.rate = rate ?? this.rate;
    this.distance = distance ?? this.distance;
  }

  Map<String, dynamic> toMap() {
    return {
      'vendorId': id,
      'vendorName': name,
      'vendorImageUrl': imageUrl,
      'vendorPos': pos,
      'vendorPhone': phone,
      'vendorUsername': username,
      'vendorAddress': address,
      'vendorCompanyName': companyName,
      'vendorCompanyAddress': companyAddress,
      'vendorDateCreated': dateCreated,
      'vendorRating': rating,
      'vendorRate': rate,
      'vendorVerified': verified,
      'distance': distance,
      'vendorSubAccountCode': subAccountCode
    };
  }
}
