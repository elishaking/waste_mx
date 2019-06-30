import 'package:flutter/material.dart';
import 'package:waste_mx/utils/data.dart';

enum UserType { Client, Vendor }

class User {
  final String id;
  String profileId;
  final String token;
  // final String phone;
  final String email;
  final UserType userType;
  // final String username;
  bool markedForDelete = false;

  User({
    @required this.id,
    this.profileId,
    @required this.token,
    // @required this.phone,
    @required this.email,
    // @required this.username,
    @required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': id,
      'userProfileId': profileId,
      'userEmail': email,
      'userUserType': userType.toString(),
      'userToken': token,
      'userMarkedForDelete': markedForDelete
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

  void update({String name, String phone, List<double> pos, String username, String address, String subAccountCode}){
    this.name = name ?? this.name;
    this.phone = phone ?? this.phone;
    this.pos = pos ?? this.pos;
    this.username = username ?? this.username;
    this.address = address ?? this.address;
    this.subAccountCode = subAccountCode ?? this.subAccountCode;
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

  Client.fromMap(Map<String, dynamic> data){
    id = data["clientId"];
    name = data[Datakeys.clientName];
    pos = data[Datakeys.clientPos] == null ? this.pos : data[Datakeys.clientPos].map<double>((x) {return double.parse(x.toString());}).toList();
    phone = data[Datakeys.clientPhone];
    username = data[Datakeys.clientUsername];
    address = data[Datakeys.clientAddress];
    dateCreated = data[Datakeys.clientDateCreated];
    subAccountCode = data["clientSubAccountCode"];
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

  void update({String name, String phone, String imageUrl, List<double> pos, String username, String address, String companyName, String companyAddress, int rating, int rate, double distance, bool verified, String subAccountCode}){
    this.name = name ?? this.name;
    this.imageUrl = imageUrl ?? this.imageUrl;
    this.phone = phone ?? this.phone;
    this.pos = pos ?? this.pos;
    this.username = username ?? this.username;
    this.address = address ?? this.address;
    this.companyName = companyName ?? this.companyName;
    this.companyAddress = companyAddress ?? this.companyAddress;
    this.rating = rating ?? this.rating;
    this.rate = rate ?? this.rate;
    this.distance = distance ?? this.distance;
    this.verified = verified ?? this.verified;
    this.subAccountCode = subAccountCode ?? this.subAccountCode;
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

  Vendor.fromMap(Map<String, dynamic> data){
    id = data["vendorId"];
    name = data[Datakeys.vendorName];
    phone = data[Datakeys.vendorPhone];
    pos = data[Datakeys.vendorPos];
    imageUrl = data["vendorimageUrl"];
    companyName = data[Datakeys.vendorCompanyName];
    companyAddress = data[Datakeys.vendorCompanyAddress];
    username = data[Datakeys.vendorUsername];
    address = data[Datakeys.vendorAddress];
    verified = data[Datakeys.vendorVerified];
    rate = data[Datakeys.vendorRate];
    rating = data[Datakeys.vendorRating];
    dateCreated = data[Datakeys.vendorDateCreated];
    subAccountCode = data["vendorSubAccountCode"];
  }
}
