import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user.dart';

class MainModel extends Model with UserModel{
  
}

class UserModel extends Model {
  User _authenticatedUser;
  String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';

  bool isLoading = false;

  Future<Map<String, dynamic>> signup(String email, String password) async{
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

    isLoading = false;
    notifyListeners();

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool success = false;
    String message = 'Authentication Success';
    if(responseData.containsKey('idToken')){
      success = true;
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
    isLoading = true;
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

    isLoading = false;
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