import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/dispose_offering.dart';

class MainModel extends Model with ConnectedModel, UserModel, DisposeOfferingModel{
  
}

class ConnectedModel extends Model{
  User _authenticatedUser;
  bool _isLoading = false;
  String _dbUrl = 'https://waste-mx.firebaseio.com/';

  bool get isLoading{
    return _isLoading;
  }
}

class UserModel extends ConnectedModel {
  String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';
  Client _client;
  Vendor _vendor;

  List<Vendor> _vendors;

  Client get client{
    return _client;
  }

  Vendor get vendor{
    return _vendor;
  }

  User get user{
    return _authenticatedUser;
  }

  List<Vendor> get vendors{
    return _vendors;
  }

  UserType _getUserType(String userTypeString){
    return userTypeString == 'UserType.Client' ? UserType.Client : UserType.Vendor;
  }

  void autoAuthenticate() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    final String expiryTimeString = prefs.getString('expiryTime');
    print(expiryTimeString);
    if(token != null){
      final DateTime now = DateTime.now();
      final parsedExpiryTime = expiryTimeString == null ? DateTime.now()
      .subtract(Duration(days: 1)) : DateTime.parse(expiryTimeString);
      if (parsedExpiryTime.isBefore(now)) {
        final http.Response response = await http.post(
          'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=$_apiKey',
          headers: {
            'Content-Type': 'application/json'
          },
          body: json.encode({
            'token': token,
            'returnSecureToken': true
          })
        );
        final Map<String, dynamic> responseData = json.decode(response.body);
        if(responseData.containsKey('idToken')){
          await _saveAuthUser(responseData);
          await _getUserData();
        } else{
          _authenticatedUser = null;
          notifyListeners();
          return;
        }
      }

      final String userEmail = prefs.getString('userEmail');
      final String userId = prefs.getString('userId');
      final UserType userType = _getUserType(prefs.getString('userType'));
      _authenticatedUser = User(
        id: userId,
        email: userEmail,
        token: token,
        userType: userType
      );
      notifyListeners();
    }
  }

  Future _saveAuthUser(responseData) async{
    _authenticatedUser = User(
      id: responseData['localId'],
      email: responseData['email'],
      token: responseData['idToken'],
      userType: UserType.Client
    );
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', responseData['idToken']);
    prefs.setString('userEmail', responseData['email']);
    prefs.setString('userId', responseData['localId']);
    prefs.setString('userType', UserType.Client.toString());

    final DateTime now = DateTime.now();
    final DateTime expiryTime =
        now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
    prefs.setString('expiryTime', expiryTime.toIso8601String());
  }

  Future _saveUserData(Map<String, dynamic> data) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    data.forEach((key, value) {
      prefs.setString(key, value.toString());
    });
  }

  Future<bool> _getUserData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if(_authenticatedUser.userType == UserType.Client){
      _client = Client(
        id: prefs.getString('clientId'),
        name: prefs.getString('clientName'),
        phone: prefs.getString('clientPhone'),
        username: prefs.getString('clientUsername'),
        address: prefs.getString('clientAddress'),
        dateCreated: prefs.getString('clientDateCreated')
      );
    } else{
      _vendor = Vendor(
        id: prefs.getString('vendorId'),
        name: prefs.getString('vendorName'),
        phone: prefs.getString('vendorPhone'),
        companyName: prefs.getString('companyName'),
        companyAddress: prefs.getString('companyAddress'),
        username: prefs.getString('vendorUsername'),
        address: prefs.getString('vendorAddress'),
        dateCreated: prefs.getString('vendorDateCreated')
      );
    }
    return true;
  }

  Future<bool> _addUser(Map<String, dynamic> userData, String collectionName) async{
    try{
      final http.Response response = await http.post(
        '$_dbUrl$collectionName.json?auth=${_authenticatedUser.token}',
        body: json.encode(userData)
      );
      if(response.statusCode != 200 && response.statusCode != 201){
        _isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      if(collectionName == "clients"){
        _client = Client(
          id: responseData['name'],
          name: userData['name'],
          phone: userData['phone'],
          username: userData['username'],
          address: userData['address'],
          dateCreated: userData['dateCreated']
        );
      } else{
        _vendor = Vendor(
          id: responseData['name'],
          name: userData['name'],
          companyName: userData['companyName'],
          companyAddress: userData['companyAddress'],
          phone: userData['phone'],
          username: userData['username'],
          address: userData['address'],
          dateCreated: userData['dateCreated']
        );
      }
      userData['id'] = responseData['name'];
      await _saveUserData(userData);
      _isLoading = false;
      notifyListeners();
      return true;
    }catch(error){
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<Map<String, dynamic>> signup(String email, String password, {Client client, Vendor vendor}) async{
    // final Map<String, dynamic> authData = 
    _isLoading = true;
    notifyListeners();

    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${_apiKey}',
      headers: {
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      })
    );

    // _isLoading = false;
    // notifyListeners();

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    if(responseData.containsKey('idToken')){
      await _saveAuthUser(responseData);
      bool userAdded = false;
      if(vendor == null){
        userAdded = await _addUser(client.toMap(), 'clients');
      } else{
        userAdded = await _addUser(vendor.toMap(), 'vendors');
      }
      success = userAdded;
      if(!success) message = 'Failed to upload user data';
    } else{
      _isLoading = false;
      notifyListeners();
      switch(responseData['error']['message']){
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

    return {'success': success, 'message': message};
  }

  Future<Map<String, dynamic>> login(String email, String password) async{
    _isLoading = true;
    notifyListeners();
    
    final http.Response response = await http.post(
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_apiKey',
      headers: {
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true
      })
    );

    _isLoading = false;
    notifyListeners();

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    int code = -1;
    if(responseData.containsKey('idToken')){
      success = true;
      await _saveAuthUser(responseData);
      await _getUserData(); //! prevent login if data not saved locally
    } else{
      switch(responseData['error']['message']){
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

    return {'success': success, 'message': message, 'code': code};
  }

  void fetchVendors(){
    _isLoading = true;
    notifyListeners();
    http.get('$_dbUrl/vendors.json').then((http.Response response){
      _isLoading = false;
      notifyListeners();
      final List<Vendor> fetchedVendorList = [];
      final Map<String, dynamic> vendorListData = json.decode(response.body);
      if(vendorListData != null){
        vendorListData.forEach((String vendorId, dynamic vendorData) {
          final Vendor product = Vendor(
            id: vendorId,
            name: vendorData['name'],
            companyName: vendorData['companyName'],
            companyAddress: vendorData['companyAddress'],
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
      notifyListeners();
    });
  }
}

class DisposeOfferingModel extends ConnectedModel{
  Map<String, List> _offerings;

  Map<String, List> get allOfferings{
    return Map.from(_offerings);
  }

  Future<Map<String, dynamic>> uploadImage(File image, {String imagePath}) async{
    final mimeTypeData = lookupMimeType(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse('https://us-central1-waste-mx.cloudfunctions.net/storeImage'));
    final file = await http.MultipartFile.fromPath('image', image.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    imageUploadRequest.files.add(file);
    if(imagePath != null){
      imageUploadRequest.fields['imagePath'] = Uri.encodeComponent(imagePath);
    }
    imageUploadRequest.headers['Authorization'] = 'Bearer ${_authenticatedUser.token}';
    try{
      final responseStream = await imageUploadRequest.send();
      final response = await http.Response.fromStream(responseStream);
      if(response.statusCode != 200 && response.statusCode != 201){
        print('Something went wrong');
        print(json.decode(response.body));
        return null;
      }
      final responseData = json.decode(response.body);
      return responseData;
    } catch(error){
      print(error);
      return null;
    }
  }

  Future<bool> addDisposeOffering(DisposeOffering offering, List<File> imageFiles) async{

  }

  Future<bool> addOffering(DisposeOffering offering, List<File> imageFiles) async{
    _isLoading = true;
    notifyListeners();
    final List uploadImageData = new List(imageFiles.length);
    final List _uploadImageUrls = new List(imageFiles.length);
    final List _uploadImagePaths = new List(imageFiles.length);
    // imageFiles.forEach((File imageFile) {
    //   uploadImageData.add(await uploadImage(imageFile));
    // });
    for(int i = 0; i < imageFiles.length; i++){
      uploadImageData[i] = await uploadImage(imageFiles[i]);
      _uploadImageUrls[i] = uploadImageData[i]['imageUrl'];
      _uploadImagePaths[i] = uploadImageData[i]['imagePath'];
    }

    if(uploadImageData == null){
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> offeringData = {
      'name': offering.name,
      'imageUrls': _uploadImageUrls,
      'price': offering.price,
      'rate': offering.rate,
      'numberOfBins': offering.numberOfBins,
      'clientName': offering.clientName,
      'clientLocation': offering.clientLocation,
      'userId': _authenticatedUser.id,
      'imagePath': _uploadImagePaths,
    };

    try{
      final http.Response response = await http.post(
        '$_dbUrl/dispose_offerings.json?auth=${_authenticatedUser.token}',
        body: json.encode(offeringData)
      );
      if(response.statusCode != 200 && response.statusCode != 201){
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
    }catch(error){
      _isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<Map<String, List>> fetchOfferings() async{
    _isLoading = true;
    notifyListeners();
    http.Response response1 = await http.get('$_dbUrl/dispose_offerings.json?auth=${_authenticatedUser.token}');
    // http.Response response2 = await http.get('$_dbUrl/recycle_offerings.json?auth=${_authenticatedUser.token}');
    _isLoading = false;
    notifyListeners();
    final List<DisposeOffering> disposeOfferings = [];
    final Map<String, dynamic> offeringsData = json.decode(response1.body);
    if(offeringsData != null){
      offeringsData.forEach((String offeringId, dynamic offeringData) {
        final DisposeOffering offering = DisposeOffering(
          id: offeringId,
          name: offeringData['title'],
          imageUrls: offeringData['imageUrls'],
          price: offeringData['price'],
          rate: offeringData['imageUrl'],
          numberOfBins: offeringData['numberOfBins'],
          clientName: offeringData['clientName'],
          clientLocation: offeringData['clientLocation'],
          userId: _authenticatedUser.id,
          imagePaths: offeringData['imagePaths'],
        );
        disposeOfferings.add(offering);
      });
      _offerings['Dispose Offerings'] = disposeOfferings;
    }
    return _offerings;
  }

  //TODO: implement update
  //TODO: implement delete
  //? make sure to add ?auth=<idToken> in the urls
}
