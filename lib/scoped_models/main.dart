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
  bool isLoading = false;
  String _dbUrl = 'https://waste-mx.firebaseio.com/';
}

class UserModel extends ConnectedModel {
  String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';
  Client _client;
  Vendor _vendor;

  Client get client{
    return _client;
  }

  Vendor get vendor{
    return _vendor;
  }

  User get user{
    return _authenticatedUser;
  }

  UserType _getUserType(String userTypeString){
    return userTypeString == 'UserType.Client' ? UserType.Client : UserType.Vendor;
  }

  void autoAuthenticate() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');
    print(token);
    if(token != null){
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
        isLoading = false;
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
      isLoading = false;
      notifyListeners();
      return true;
    }catch(error){
      isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future<Map<String, dynamic>> signup(String email, String password, {Client client, Vendor vendor}) async{
    // final Map<String, dynamic> authData = 
    isLoading = true;
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

    // isLoading = false;
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
      isLoading = false;
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
    isLoading = true;
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

    // isLoading = false;
    // notifyListeners();

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
}

class DisposeOfferingModel extends ConnectedModel{
  List<DisposeOffering> _disposeOfferings = [];

  List<DisposeOffering> get allDisposeOfferings{
    return List.from(_disposeOfferings);
  }

  Future<Map<String, dynamic>> uploadImage(File image, {String imagePath}) async{
    final mimeTypeData = lookupMimeType(image.path).split('/');
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse('uri'));
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

  Future<bool> addOffering(DisposeOffering offering, File image) async{
    isLoading = true;
    notifyListeners();
    final uploadImageData = await uploadImage(image);

    if(uploadImageData == null){
      print('Upload Failed');
      return false;
    }

    final Map<String, dynamic> offeringData = {
      'name': offering.name,
      'imageUrl': uploadImageData['imageUrl'],
      'price': offering.price,
      'rate': offering.rate,
      'numberOfBins': offering.numberOfBins,
      'clientName': offering.clientName,
      'clientLocation': offering.clientLocation,
      'userId': _authenticatedUser.id,
      'imagePath': uploadImageData['imagePath'],
    };

    try{
      final http.Response response = await http.post(
        '$_dbUrl?auth=${_authenticatedUser.token}',
        body: json.encode(offeringData)
      );
      if(response.statusCode != 200 && response.statusCode != 201){
        isLoading = false;
        notifyListeners();
        return false;
      }
      final Map<String, dynamic> responseData = json.decode(response.body);
      //? save uploaded offering locally
      final DisposeOffering newOffering = DisposeOffering(
        id: responseData['name'],
        name: offering.name,
        imageUrl: uploadImageData['imageUrl'],
        price: offering.price,
        rate: offering.rate,
        numberOfBins: offering.numberOfBins,
        clientName: offering.clientName,
        clientLocation: offering.clientLocation,
        userId: _authenticatedUser.id,
        imagePath: uploadImageData['imagePath'],
      );
      _disposeOfferings.add(newOffering);
      isLoading = false;
      notifyListeners();
      return true;
    }catch(error){
      isLoading = false;
      notifyListeners();
      print(error);
      return false;
    }
  }

  Future fetchOfferings(){
    isLoading = true;
    notifyListeners();
    return http.get('$_dbUrl?auth=${_authenticatedUser.token}').then((http.Response response){
      isLoading = false;
      notifyListeners();
      final List<DisposeOffering> fetchedOfferings = [];
      final Map<String, dynamic> offeringsData = json.decode(response.body);
      if(offeringsData != null){
        offeringsData.forEach((String offeringId, dynamic productData) {
          final DisposeOffering offering = DisposeOffering(
            id: offeringId,
            name: offeringsData['title'],
            imageUrl: offeringsData['imageUrl'],
            price: offeringsData['price'],
            rate: offeringsData['imageUrl'],
            numberOfBins: offeringsData['numberOfBins'],
            clientName: offeringsData['clientName'],
            clientLocation: offeringsData['clientLocation'],
            userId: _authenticatedUser.id,
            imagePath: offeringsData['imagePath'],
          );
          fetchedOfferings.add(offering);
        });
        _disposeOfferings = fetchedOfferings;
      }
    });
  }

  //TODO: implement update
  //TODO: implement delete
  //? make sure to add ?auth=<idToken> in the urls
}
