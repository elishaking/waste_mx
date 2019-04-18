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
}

class Client {
  final String id;
  final String name;
  final String phone;
  final String username;
  final String address;
  final String dateCreated;

  Client(
      {this.id,
      this.name,
      this.phone,
      this.username,
      this.address,
      this.dateCreated});

  Map<String, dynamic> toMap() {
    return {
      'clientId': id,
      'clientName': name,
      'clientPhone': phone,
      'clientUsername': username,
      'clientAddress': address,
      'clientDateCreated': dateCreated,
    };
  }
}

class Vendor {
  final String id;
  final String name;
  final String imageUrl;
  final String companyName;
  final String companyAddress;
  final String phone;
  final String username;
  final String address;
  final String dateCreated;
  final int rating;
  final int rate;
  final bool verified;

  Vendor(
      {this.id,
      this.name,
      this.imageUrl,
      this.companyName,
      this.companyAddress,
      this.phone,
      this.username,
      this.address,
      this.dateCreated,
      this.rating,
      this.rate,
      this.verified});

  Map<String, dynamic> toMap() {
    return {
      'vendorId': id,
      'vendorName': name,
      'vendorImageUrl': imageUrl,
      'vendorPhone': phone,
      'vendorUsername': username,
      'vendorAddress': address,
      'vendorCompanyName': companyName,
      'vendorCompanyAddress': companyAddress,
      'vendorDateCreated': dateCreated,
      'vendorRating': rating,
      'vendorRate': rate,
      'vendorVerified': verified,
    };
  }
}
