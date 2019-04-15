import 'dart:convert';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../models/user.dart';
import '../models/dispose_offering.dart';

class MainModel extends Model with ConnectedModel, UserModel{
  
}

class ConnectedModel extends Model{
  Client _authenticatedUser;
  bool _isLoading = false;
  
}

class UserModel extends ConnectedModel {
  String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';

  Future<Map<String, dynamic>> signup(String email, String password) async{
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

    _isLoading = false;
    notifyListeners();

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    if(responseData.containsKey('idToken')){
      success = true;
      _authenticatedUser = Client(
        id: responseData['localId'],
        email: email,
        token: responseData['idToken']
      );
    } else{
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
      'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=${_apiKey}',
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
    _isLoading = true;
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
        'url',
        body: json.encode(offeringData)
      );
      if(response.statusCode != 200 && response.statusCode != 201){
        _isLoading = false;
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

  Future fetchOfferings(){
    _isLoading = true;
    notifyListeners();
    return http.get('url?auth=${_authenticatedUser.token}').then((http.Response response){
      _isLoading = false;
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
}
