/*
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'dart:math';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'package:firebase_auth/firebase_auth.dart';

import '../models/user.dart';
import '../models/dispose_offering.dart';
import '../models/recycle_offering.dart';
import '../models/decluster_offering.dart';
import '../models/http.dart';
import '../models/transaction.dart';

import '../utils/data.dart';

class MainModel extends Model with ConnectedModel, UserModel, OfferingModel, TransactionModel {}

class ConnectedModel extends Model {
  User _authenticatedUser;
  ResponseInfo _authResponse;
  Client _client;
  Vendor _vendor;
  bool _isLoading = false;
  bool _gettingLocation = false;
  String _dbUrl = "https://waste-mx.firebaseio.com";
  int _httpTimeout = 5;

  ResponseInfo get authResponse{
    return _authResponse;
  }

  bool get isLoading {
    return _isLoading;
  }

  bool get gettingLocation{
    return _gettingLocation;
  }

  void toggleLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}

class UserModel extends ConnectedModel {
  String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';

  List<Vendor> _vendors;

  Client get client {
    return _client;
  }

  Vendor get vendor {
    return _vendor;
  }

  User get user {
    return _authenticatedUser;
  }

  List<Vendor> get vendors {
    return _vendors;
  }

  UserType _getUserType(String userTypeString) {
    return userTypeString == 'UserType.Client'
        ? UserType.Client
        : UserType.Vendor;
  }

  void autoAuthenticate() async {
    _isLoading = true;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final UserType userType = _getUserType(prefs.getString('userType'));
    final String expiryTimeString = prefs.getString('expiryTime');
    _authResponse = ResponseInfo(false, 'User not Saved', -1);

    if (token != null) {
      // print(token);
      final DateTime now = DateTime.now();
      final parsedExpiryTime = expiryTimeString == null
          ? DateTime.now().subtract(Duration(days: 1))
          : DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        final http.Response response = await http.post(
          "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=$_apiKey",
          headers: {'Content-Type': 'application/json'},
          body: json.encode({'token': token, 'returnSecureToken': true}))
          .catchError((error) {
            print(error.toString());
            _isLoading = false;
            notifyListeners();
            _authResponse = ResponseInfo(false, error, -1);
          });
            // .timeout(Duration(seconds: _httpTimeout), 
            // onTimeout: (){
            //   _authenticatedUser = null;
            //   _isLoading = false;
            //   notifyListeners();
            // });
        if(response == null) return;
        final Map<String, dynamic> responseData = json.decode(response.body);
        // print(response.body);
        if (responseData.containsKey('idToken')) {
          await _saveAuthUser(responseData, userType);
        } else {
          _authResponse = ResponseInfo(true, 'Could not save User info', -1);
          _authenticatedUser = null;
          _isLoading = false;
          notifyListeners();
        }
      }

      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      _authenticatedUser =
          User(id: userId, email: userEmail, token: token, userType: userType);
      
      await _getUserData();
      _authResponse = ResponseInfo(true, 'Successful Authentication', -1);
      _isLoading = false;
      notifyListeners();
    } else{
      _authResponse = ResponseInfo(true, 'User not created', -1);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future _saveAuthUser(responseData, UserType userType) async {
    _authenticatedUser = User(
        id: responseData['localId'],
        email: responseData['email'],
        token: responseData['idToken'],
        userType: userType);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', responseData['idToken']);
    prefs.setString('userEmail', responseData['email']);
    prefs.setString('userId', responseData['localId']);
    prefs.setString('userType', userType.toString());

    final DateTime now = DateTime.now();
    final DateTime expiryTime =
        now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
    prefs.setString('expiryTime', expiryTime.toIso8601String());
  }

  Future _saveUserData(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data.forEach((key, value) {
      prefs.setString(key, value.toString());
    });
  }

  Future<bool> _getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_authenticatedUser.userType == UserType.Client) {
      if(prefs.getString(Datakeys.clientId) == null){
        http.Response response = await http
          .get('$_dbUrl/clients/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        String key = responseData.keys.toList()[0];
        _client = Client(
          id: key,
          name: responseData[key][Datakeys.clientName],
          pos: responseData[key][Datakeys.clientPos].map<double>((x) {return double.parse(x.toString());}).toList(),
          phone: responseData[key][Datakeys.clientPhone],
          username: responseData[key][Datakeys.clientUsername],
          address: responseData[key][Datakeys.clientAddress],
          dateCreated: responseData[key][Datakeys.clientDateCreated]
        );
      } else{
        String pos = prefs.getString(Datakeys.clientPos);
        _client = Client(
          id: prefs.getString(Datakeys.clientId),
          name: prefs.getString(Datakeys.clientName),
          pos: json.decode(pos == null ? "[0,0]" : pos).map<double>((x) {return double.parse(x.toString());}).toList(),
          phone: prefs.getString(Datakeys.clientPhone),
          username: prefs.getString(Datakeys.clientUsername),
          address: prefs.getString(Datakeys.clientAddress),
          dateCreated: prefs.getString(Datakeys.clientDateCreated));
        print(_client.pos);
      }
    } else {
      if(prefs.getString(Datakeys.clientId) == null){
        http.Response response = await http
          .get('$_dbUrl/clients/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
        Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        String key = responseData.keys.toList()[0];
        _vendor = Vendor(
          id: key,
          name: responseData[key][Datakeys.vendorName],
          phone: responseData[key][Datakeys.vendorPhone],
          pos: responseData[key][Datakeys.vendorPos],
          companyName: responseData[key][Datakeys.vendorCompanyName],
          companyAddress: responseData[key][Datakeys.vendorCompanyAddress],
          username: responseData[key][Datakeys.vendorUsername],
          address: responseData[key][Datakeys.vendorAddress],
          verified: responseData[key][Datakeys.vendorVerified],
          rate: responseData[key][Datakeys.vendorRate],
          rating: responseData[key][Datakeys.vendorRating],
          dateCreated: responseData[key][Datakeys.vendorDateCreated]
        );
      } else{
        _vendor = Vendor(
          id: prefs.getString(Datakeys.vendorId),
          name: prefs.getString(Datakeys.vendorName),
          phone: prefs.getString(Datakeys.vendorPhone),
          pos: json.decode(prefs.getString(Datakeys.vendorPos)),
          companyName: prefs.getString(Datakeys.vendorCompanyName),
          companyAddress: prefs.getString(Datakeys.vendorCompanyAddress),
          username: prefs.getString(Datakeys.vendorUsername),
          address: prefs.getString(Datakeys.vendorAddress),
          dateCreated: prefs.getString(Datakeys.vendorDateCreated));
      }
    }
    return true;
  }

  Future<bool> _addUser(
      Map<String, dynamic> userData, String collectionName, String userId) async {
    toggleLoading(true);
    try {
      Geolocator geolocator = Geolocator();
        Position position = await geolocator
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      List<double> pos = [position.latitude, position.longitude];
      userData[collectionName.substring(0, collectionName.length - 1) + "Pos"] = pos;

      final http.Response response = await http.post(
          "$_dbUrl/$collectionName/$userId.json?auth=${_authenticatedUser.token}",
          body: json.encode(userData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        toggleLoading(false);
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (collectionName == "clients") {
        _client = Client(
            id: responseData['name'],
            name: userData[Datakeys.clientName],
            pos: pos,
            phone: userData[Datakeys.clientPhone],
            username: userData[Datakeys.clientUsername],
            address: userData[Datakeys.clientAddress],
            dateCreated: userData[Datakeys.clientDateCreated]);
        print(json.encode(_client.toMap()));
      } else {
        _vendor = Vendor(
            id: responseData['name'],
            name: userData[Datakeys.vendorName],
            pos: pos,
            companyName: userData[Datakeys.vendorCompanyName],
            companyAddress: userData[Datakeys.vendorCompanyAddress],
            phone: userData[Datakeys.vendorPhone],
            username: userData[Datakeys.vendorUsername],
            address: userData[Datakeys.vendorAddress],
            verified: userData[Datakeys.vendorVerified],
            rate: userData[Datakeys.vendorRating],
            rating: userData[Datakeys.vendorRating],
            dateCreated: userData[Datakeys.vendorDateCreated]);
      }
      userData['id'] = responseData['name'];
      await _saveUserData(userData);
      toggleLoading(false);
      return true;
    } catch (error) {
      toggleLoading(false);
      print(error);
      return false;
    }
  }

  Future<bool> updateUser(Map<String, dynamic> userData, String collectionName) async{
    try {
      final http.Response response = await http.post(
          "$_dbUrl/$collectionName/${collectionName == 'clients' ? _client.id : _vendor.id}.json?auth=${_authenticatedUser.token}",
          body: json.encode(userData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (collectionName == "clients") {
        _client = Client(
            id: responseData['name'],
            name: userData[Datakeys.clientName],
            phone: userData[Datakeys.clientPhone],
            username: userData[Datakeys.clientUsername],
            address: userData[Datakeys.clientAddress],
            dateCreated: userData[Datakeys.clientDateCreated]);
        print(json.encode(_client.toMap()));
      } else {
        _vendor = Vendor(
            id: responseData['name'],
            name: userData[Datakeys.vendorName],
            companyName: userData[Datakeys.vendorCompanyName],
            companyAddress: userData[Datakeys.vendorCompanyAddress],
            phone: userData[Datakeys.vendorPhone],
            username: userData[Datakeys.vendorUsername],
            address: userData[Datakeys.vendorAddress],
            dateCreated: userData[Datakeys.vendorDateCreated]);
      }
      userData['id'] = responseData['name'];
      await _saveUserData(userData);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }
  
  Future<Map<String, dynamic>> signup(String email, String password,
      {Client client, Vendor vendor}) async {
    // final Map<String, dynamic> authData =
    toggleLoading(true);

    final http.Response response = await http.post(
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${_apiKey}",
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    // _isLoading = false;
    // notifyListeners();

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    if (responseData.containsKey('idToken')) {
      bool userAdded = false;
      if (vendor == null) {
        await _saveAuthUser(responseData, UserType.Client);
        userAdded = await _addUser(client.toMap(), 'clients', _authenticatedUser.id);
      } else {
        await _saveAuthUser(responseData, UserType.Vendor);
        userAdded = await _addUser(vendor.toMap(), 'vendors', _authenticatedUser.id);
      }
      success = userAdded;
      if (!success) message = 'Failed to upload user data';
    } else {
      switch (responseData['error']['message']) {
        case 'EMAIL_EXISTS':
          message = 'Your email already exists';
          break;

        case 'INVALID_EMAIL':
          message = 'Your email is invalid';
          break;

        default:
          message = 'Something went wrong';
          print(responseData['error']['message']);
          break;
      }
    }

    toggleLoading(false);
    return {'success': success, 'message': message};
  }

  Future<Map<String, dynamic>> login(String email, String password, UserType userType) async {
    _isLoading = true;
    notifyListeners();

    final http.Response response = await http.post(
        "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_apiKey",
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));

    // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: email,
    //   password: password
    // );
    // .catchError((e){
    //   print(e);
    //   // print(e['message']);
    //   // print(json.encode(e));
    // });

    print(json.encode(user.toString()));

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    int code = -1;
    if (responseData.containsKey('idToken')) {
    // if(user.){
      await _saveAuthUser(responseData, userType);
      await _getUserData(); //! prevent login if data not saved locally
      success = true;
    } else {
      switch (responseData['error']['message']) {
        case 'EMAIL_NOT_FOUND':
          message = 'Your email is not registered';
          code = 0;
          break;

        case 'INVALID_PASSWORD':
          message = 'Your password is invalid';
          code = 1;
          break;

        case 'USER_DISABLED':
          message = 'Your account has been disabled';
          code = 2;
          break;

        default:
          message = 'Something went wrong';
          print(responseData['error']['message']);
          break;
      }
    }

    _isLoading = false;
    notifyListeners();

    return {'success': success, 'message': message, 'code': code};
  }

  Future<bool> logout() async{
    _authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('userEmail');
    prefs.remove('userId');
    return true;
  }
  
  void fetchVendors() {
    _isLoading = true;
    notifyListeners();

    http.get('$_dbUrl/vendors.json').then((http.Response response) {
      final List<Vendor> fetchedVendorList = [];
      final Map<String, dynamic> vendorListData = json.decode(response.body);
      if (vendorListData != null) {
        vendorListData.forEach((String vendorId, dynamic vendorData) {
          final Vendor product = Vendor(
            id: vendorId,
            name: vendorData['name'],
            companyName: vendorData[Datakeys.vendorCompanyName],
            companyAddress: vendorData[Datakeys.vendorCompanyAddress],
            phone: vendorData['phone'],
            username: vendorData['username'],
            address: vendorData['address'],
            dateCreated: vendorData['dateCreated'],
            rating: vendorData['rating'],
            rate: vendorData['rate'],
            verified: vendorData['verified'],
          );
          fetchedVendorList.add(product);
        });
        _vendors = fetchedVendorList;
      }
      _isLoading = false;
      notifyListeners();
    }).timeout(Duration(seconds: _httpTimeout), onTimeout: () {
      _isLoading = false;
      notifyListeners();
    });
  }
}

class OfferingModel extends ConnectedModel {
  Map<String, List> _offerings = Map<String, List>();

  Map<String, List> get allOfferings {
    return Map.from(_offerings);
  }

  Future<String> getLocation() async {
    _gettingLocation = true;
    notifyListeners();

    try{
      Geolocator geolocator = Geolocator();
      Position position = await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        // .timeout(Duration(seconds: 10), onTimeout: (){
        //   print('get location timeout');
        // });
      print(position.longitude);
      if(position == null) {
        _gettingLocation = false;
        notifyListeners();
        return '';
      }
      
      // String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=40.714224,-73.961452&location_type=ROOFTOP&result_type=street_address&key=YOUR_API_KEY";
      List<Placemark> placemark =  await geolocator.placemarkFromPosition(position)
          .catchError((error){
            print(error);
          });
          // .timeout(Duration(seconds: 5), onTimeout: (){
          //   print('get location placement timeout');
          // });
      if(placemark == null) {
        _gettingLocation = false;
        notifyListeners();
        return '';
      }

      _gettingLocation = false;
      notifyListeners();
      // print('position: ' + position.latitude.toString());

      Placemark p = placemark[0];
      
      return '${p.thoroughfare}, ${p.postalCode}, ${p.locality}, ${p.administrativeArea}, ${p.country}';
    
    } catch(e){
      print(e.toString());
      _gettingLocation = false;
      notifyListeners();
      return '';
    }
  }

  Future<Map<String, dynamic>> uploadImage(File image,
      {String imagePath}) async {
    final mimeTypeData = lookupMimeType(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(
            "https://us-central1-waste-mx.cloudfunctions.net/storeImage"));
    final file = await http.MultipartFile.fromPath('image', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    if (imagePath != null) {
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }
    imageUploadRequest.headers['Authorization'] =
        'Bearer ${_authenticatedUser.token}';
    try {
      final responseStream = await imageUploadRequest.send();
      final response = await http.Response.fromStream(responseStream);
      if (response.statusCode != 200 && response.statusCode != 201) {
        print('Something went wrong');
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<List<Vendor>> fetchClosestVendors() async{
    toggleLoading(true);
    final response = await http.post("https://us-central1-waste-mx.cloudfunctions.net/fetchClosestVendors", body: json.encode({
      'pos': _client.pos
    }),
    headers: {
      'Authorization': 'Bearer ${_authenticatedUser.token}',
      'Content-Type': 'application/json'
    });
    print(response.body);
    List<Vendor> _closestVendors = List<Vendor>();
    Map<String, dynamic> _closestVendorsData = json.decode(response.body);
    _closestVendorsData.forEach((String key, dynamic value){
      print(key);
      value.forEach((String key, dynamic value){
        print(key);
        value.forEach((String key, dynamic vendorData){
          _closestVendors.add(
            Vendor(
              id: key,
              name: vendorData[Datakeys.vendorName],
              username: vendorData[Datakeys.vendorUsername],
              phone: vendorData[Datakeys.vendorPhone],
              address: vendorData[Datakeys.vendorAddress],
              dateCreated: vendorData[Datakeys.vendorDateCreated],
              pos: vendorData[Datakeys.vendorPos].map<double>((x) {return double.parse(x.toString());}).toList(),
              verified: vendorData[Datakeys.vendorVerified],
              rating: vendorData[Datakeys.vendorRating],
              rate: vendorData[Datakeys.vendorRate],
              distance: vendorData["distance"]
            )
          );
        });
      });
    });
    // toggleLoading(false);
    _isLoading = false;
    return _closestVendors;
  }

  //! join the 3 methods below
  Future<bool> addDeclusterOffering(
      DeclusterOffering offering, List<File> imageFiles) async {
    _isLoading = true;
    notifyListeners();
    final List uploadImageData = new List(imageFiles.length);
    final List _uploadImageUrls = new List(imageFiles.length);
    final List _uploadImagePaths = new List(imageFiles.length);
    // imageFiles.forEach((File imageFile) {
    //   uploadImageData.add(await uploadImage(imageFile));
    // });
    for (int i = 0; i < imageFiles.length; i++) {
      uploadImageData[i] = await uploadImage(imageFiles[i]);
      _uploadImageUrls[i] = uploadImageData[i]['imageUrl'];
      _uploadImagePaths[i] = uploadImageData[i]['imagePath'];
    }

    if (uploadImageData == null) {
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> offeringData = {
      'name': offering.name,
      'imageUrls': _uploadImageUrls,
      'price': offering.price,
      'rate': offering.rate,
      // 'weight': offering.weight,
      Datakeys.clientName: offering.clientName,
      'clientLocation': offering.clientLocation,
      'userId': _authenticatedUser.id,
      'imagePath': _uploadImagePaths,
    };

    try {
      final http.Response response = await http.post(
          '$_dbUrl/recycle_offerings.json?auth=${_authenticatedUser.token}',
          body: json.encode(offeringData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //? save uploaded offering locally
      final RecycleOffering newDisposeOffering = RecycleOffering(
        id: responseData['name'],
        name: offering.name,
        imageUrls: _uploadImageUrls,
        price: offering.price,
        rate: offering.rate,
        // weight: offering.weight,
        clientName: offering.clientName,
        clientLocation: offering.clientLocation,
        userId: _authenticatedUser.id,
        imagePaths: _uploadImagePaths,
      );
      _offerings['Decluster Offerings'].add(newDisposeOffering);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> addRecycleOffering(
      RecycleOffering offering, List<File> imageFiles) async {
    _isLoading = true;
    notifyListeners();
    final List uploadImageData = new List(imageFiles.length);
    final List _uploadImageUrls = new List(imageFiles.length);
    final List _uploadImagePaths = new List(imageFiles.length);
    // imageFiles.forEach((File imageFile) {
    //   uploadImageData.add(await uploadImage(imageFile));
    // });
    for (int i = 0; i < imageFiles.length; i++) {
      uploadImageData[i] = await uploadImage(imageFiles[i]);
      _uploadImageUrls[i] = uploadImageData[i]['imageUrl'];
      _uploadImagePaths[i] = uploadImageData[i]['imagePath'];
    }

    if (uploadImageData == null) {
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> offeringData = {
      'name': offering.name,
      'imageUrls': _uploadImageUrls,
      'price': offering.price,
      'rate': offering.rate,
      'weight': offering.weight,
      Datakeys.clientName: offering.clientName,
      'clientLocation': offering.clientLocation,
      'userId': _authenticatedUser.id,
      'imagePath': _uploadImagePaths,
    };

    try {
      final http.Response response = await http.post(
          '$_dbUrl/recycle_offerings.json?auth=${_authenticatedUser.token}',
          body: json.encode(offeringData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //? save uploaded offering locally
      final RecycleOffering newDisposeOffering = RecycleOffering(
        id: responseData['name'],
        name: offering.name,
        imageUrls: _uploadImageUrls,
        price: offering.price,
        rate: offering.rate,
        weight: offering.weight,
        clientName: offering.clientName,
        clientLocation: offering.clientLocation,
        userId: _authenticatedUser.id,
        imagePaths: _uploadImagePaths,
      );
      _offerings['Recycle Offerings'].add(newDisposeOffering);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<bool> addOffering(
      DisposeOffering offering, List<File> imageFiles) async {
    _isLoading = true;
    notifyListeners();
    // print(imageFiles[0].uri);
    final List uploadImageData = new List(imageFiles.length);
    final List _uploadImageUrls = new List(imageFiles.length);
    final List _uploadImagePaths = new List(imageFiles.length);
    // imageFiles.forEach((File imageFile) {
    //   uploadImageData.add(await uploadImage(imageFile));
    // });
    for (int i = 0; i < imageFiles.length; i++) {
      uploadImageData[i] = await uploadImage(imageFiles[i]);
      print(uploadImageData[i]);
      _uploadImageUrls[i] = uploadImageData[i]['imageUrl'];
      _uploadImagePaths[i] = uploadImageData[i]['imagePath'];
    }

    if (uploadImageData == null) {
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> offeringData = {
      'name': offering.name,
      'imageUrls': _uploadImageUrls,
      'price': offering.price,
      'rate': offering.rate,
      'numberOfBins': offering.numberOfBins,
      Datakeys.clientName: offering.clientName,
      'clientLocation': offering.clientLocation,
      'userId': _authenticatedUser.id,
      'imagePath': _uploadImagePaths,
    };

    try {
      final http.Response response = await http.post(
          '$_dbUrl/dispose_offerings.json?auth=${_authenticatedUser.token}',
          body: json.encode(offeringData));
      if (response.statusCode != 200 && response.statusCode != 201) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //? save uploaded offering locally
      final DisposeOffering newDisposeOffering = DisposeOffering(
        id: responseData['name'],
        name: offering.name,
        imageUrls: _uploadImageUrls,
        price: offering.price,
        rate: offering.rate,
        numberOfBins: offering.numberOfBins,
        clientName: offering.clientName,
        clientLocation: offering.clientLocation,
        userId: _authenticatedUser.id,
        imagePaths: _uploadImagePaths,
      );
      _offerings['Dispose Offerings'].add(newDisposeOffering);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  void fetchOfferings() async {
    _isLoading = true;
    notifyListeners();
    http.Response response1 = await http
        .get('$_dbUrl/dispose_offerings.json?auth=${_authenticatedUser.token}');
    // print(response1.body);
    // http.Response response2 = await http.get('$_dbUrl/recycle_offerings.json?auth=${_authenticatedUser.token}');
    _isLoading = false;
    notifyListeners();
    final List<DisposeOffering> disposeOfferings = [];
    final Map<String, dynamic> offeringsData = json.decode(response1.body);
    if (offeringsData != null) {
      offeringsData.forEach((String offeringId, dynamic offeringData) {
        final DisposeOffering offering = DisposeOffering(
          id: offeringId,
          name: "house", //offeringData['title'],
          iconUrl: 'assets/throw-to-paper-bin.png',
          imageUrls: offeringData['imageUrls'],
          price: offeringData['price'],
          rate: offeringData['imageUrl'],
          numberOfBins: offeringData['numberOfBins'],
          clientName: offeringData[Datakeys.clientName],
          clientLocation: offeringData['clientLocation'],
          userId: _authenticatedUser.id,
          imagePaths: offeringData['imagePaths'],
          date: DateTime.now().month.toString()
        );
        disposeOfferings.add(offering);
      });
      _offerings['Dispose Offerings'] = disposeOfferings;
    }
  }

  //TODO: implement update
  //TODO: implement delete
  //? make sure to add ?auth=<idToken> in the urls
}

class TransactionModel extends ConnectedModel{
  Wallet _wallet;
  String _authEmail = "test4@skyblazar.com";
  String _walletToken;

  Wallet get wallet{
    return _wallet;
  }

  String _kurepayUrl = "https://wallet.kurepay.com/api/v2";
  Future registerWallet([bool toggle = true]) async{
    if(toggle) toggleLoading(true);

    Random _random = Random.secure();
    String _password = String.fromCharCodes(List.generate(12, (index){
      return _random.nextInt(33)+89;
    }));

    Map<String, dynamic> data = {
      "fullname": _client.name,
      "email": _authEmail, // _authenticatedUser.email,
      "password": _password,
      "activateEmail": 1,
      "refId": 861699
    };
    String dataString = jsonEncode(data);
    print(dataString);

    http.Response response = await http.post("$_kurepayUrl/auth/register", body: dataString,
    headers: {
      "Content-Type": "application/json",
    });
    print(response.body);

    if(json.decode(response.body)["status"] == false) return;

    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: "KurePayPassword", value: _password);
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("pbackup", _password);

    http.Response dbWalletResponse = await http.post("$_dbUrl/wallets/${_authenticatedUser.id}.json", 
      body: json.encode(data));

    Map<String, dynamic> responseData = json.decode(dbWalletResponse.body);
    _wallet = Wallet(
      id: responseData['name'],
      fullname: _client.name,
      email: _authEmail,// _authenticatedUser.email,
    );

    toggleLoading(false);
  }

  Future loginWallet() async{
    toggleLoading(true);

    FlutterSecureStorage storage = FlutterSecureStorage();
    String _password = await storage.read(key: "KurePayPassword");
    print(_password);
    if(_password == null) return registerWallet(false);

    Map<String, dynamic> data = {
      "email": _authEmail,// _authenticatedUser.email,
      "password": _password
    };

    http.Response response = await http.post("$_kurepayUrl/auth/login", body: json.encode(data), headers: {
      "Content-Type": "application/json",
    });
    print(response.body);
    Map<String, dynamic> responseData = jsonDecode(response.body);
    _walletToken = responseData["token"];
    // _wallet = Wallet(
    //   fullname: responseData["fullname"],
    //   email: responseData["email"],
    //   refId: responseData["refId"]
    // );

    http.Response dashboardResponse = await http.get("$_kurepayUrl/dashboard",
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_walletToken"
    });
    print(dashboardResponse.body);
    Map<String, dynamic> dashboardData = jsonDecode(dashboardResponse.body)["data"];
    _wallet = Wallet(
      fullname: responseData["fullname"],
      email: responseData["email"],
      refId: responseData["refId"],
      balance: dashboardData["balance"],
      transactions: dashboardData["transactions"],
      localCurrency: dashboardData["localCurrency"]
    );
    toggleLoading(false);
  }

  Future creditWallet(double amount, CardDetails _cardDetails) async {
    toggleLoading(true);
    http.Response response = await http.post("https://payment.kurepay.com/api/charge-card",
    body: jsonEncode({
      "customerEmail": _authEmail,
      "reference": DateTime.now().toIso8601String(),
      "number": "50785078507850784",
      "expiry_month": "11",
      "expiry_year": "19",
      "cvv": "844",
      "pin": "0000",
      "unit_cost": "1200",
      "customerFirstName": "King",
      "customerLastName": "Test",
      "phone": "+2348181818181",
      "item": "Credit Wallet",
      "description": "Add money to KurePay wallet for WasteMX"
    }), //_cardDetails.toMap()
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_walletToken"
    });
    print(response.body);
    toggleLoading(false);
  }
}
*/
