// import 'dart:convert';
// import 'dart:async';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// import 'package:waste_mx/models/http.dart';
// import 'package:waste_mx/models/user.dart';
// import 'package:waste_mx/utils/data.dart';

// import './main.dart';

// class UserModel extends ConnectedModel {
//   String _apiKey = 'AIzaSyA5EgolK6BG47l3XLsiZlKVrx96djJuGtI';

//   UserType _getUserType(String userTypeString) {
//     return userTypeString == 'UserType.Client'
//         ? UserType.Client
//         : UserType.Vendor;
//   }

//   void autoAuthenticate() async {
//     super.toggleLoading(true);

//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final String token = prefs.getString('token');
//     final UserType userType = _getUserType(prefs.getString('userType'));
//     final String expiryTimeString = prefs.getString('expiryTime');
//     super.authResponse = ResponseInfo(false, 'User not Saved', -1);

//     if (token != null) {
//       // print(token);
//       final DateTime now = DateTime.now();
//       final parsedExpiryTime = expiryTimeString == null
//           ? DateTime.now().subtract(Duration(days: 1))
//           : DateTime.parse(expiryTimeString);
//       if (parsedExpiryTime.isBefore(now)) {
//         final http.Response response = await http.post(
//           "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyCustomToken?key=$_apiKey",
//           headers: {'Content-Type': 'application/json'},
//           body: json.encode({'token': token, 'returnSecureToken': true}))
//           .catchError((error) {
//             print(error.toString());
//             toggleLoading(false);
//             _authResponse = ResponseInfo(false, error, -1);
//           });
//             // .timeout(Duration(seconds: _httpTimeout), 
//             // onTimeout: (){
//             //   _authenticatedUser = null;
//             //   _isLoading = false;
//             //   notifyListeners();
//             // });
//         if(response == null) return;
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         // print(response.body);
//         if (responseData.containsKey('idToken')) {
//           await _saveAuthUser(responseData, userType);
//         } else {
//           _authResponse = ResponseInfo(true, 'Could not save User info', -1);
//           _authenticatedUser = null;
//           toggleLoading(false);
//         }
//       }

//       final String userEmail = prefs.getString('userEmail');
//       final String userId = prefs.getString('userId');
//       _authenticatedUser =
//           User(id: userId, email: userEmail, token: token, userType: userType);
      
//       await _getUserData();
//       _authResponse = ResponseInfo(true, 'Successful Authentication', -1);
//       toggleLoading(false);
//     } else{
//       _authResponse = ResponseInfo(true, 'User not created', -1);
//       toggleLoading(false);
//     }
//   }

//   Future _saveAuthUser(responseData, UserType userType) async {
//     _authenticatedUser = User(
//         id: responseData['localId'],
//         email: responseData['email'],
//         token: responseData['idToken'],
//         userType: userType);
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString('token', responseData['idToken']);
//     prefs.setString('userEmail', responseData['email']);
//     prefs.setString('userId', responseData['localId']);
//     prefs.setString('userType', userType.toString());

//     final DateTime now = DateTime.now();
//     final DateTime expiryTime =
//         now.add(Duration(seconds: int.parse(responseData['expiresIn'])));
//     prefs.setString('expiryTime', expiryTime.toIso8601String());
//   }

//   Future _saveUserData(Map<String, dynamic> data) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     data.forEach((key, value) {
//       prefs.setString(key, value.toString());
//     });
//   }

//   Future<bool> _getUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (_authenticatedUser.userType == UserType.Client) {
//       if(prefs.getString(Datakeys.clientId) == null){
//         http.Response response = await http
//           .get('$_dbUrl/clients/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
//         Map<String, dynamic> responseData = json.decode(response.body);
//         print(responseData);
//         String key = responseData.keys.toList()[0];
//         _client = Client(
//           id: key,
//           name: responseData[key][Datakeys.clientName],
//           pos: responseData[key][Datakeys.clientPos].map<double>((x) {return double.parse(x.toString());}).toList(),
//           phone: responseData[key][Datakeys.clientPhone],
//           username: responseData[key][Datakeys.clientUsername],
//           address: responseData[key][Datakeys.clientAddress],
//           dateCreated: responseData[key][Datakeys.clientDateCreated]
//         );
//       } else{
//         String pos = prefs.getString(Datakeys.clientPos);
//         _client = Client(
//           id: prefs.getString(Datakeys.clientId),
//           name: prefs.getString(Datakeys.clientName),
//           pos: json.decode(pos == null ? "[0,0]" : pos).map<double>((x) {return double.parse(x.toString());}).toList(),
//           phone: prefs.getString(Datakeys.clientPhone),
//           username: prefs.getString(Datakeys.clientUsername),
//           address: prefs.getString(Datakeys.clientAddress),
//           dateCreated: prefs.getString(Datakeys.clientDateCreated));
//         print(_client.pos);
//       }
//     } else {
//       if(prefs.getString(Datakeys.clientId) == null){
//         http.Response response = await http
//           .get('$_dbUrl/clients/${_authenticatedUser.id}.json?auth=${_authenticatedUser.token}');
//         Map<String, dynamic> responseData = json.decode(response.body);
//         print(responseData);
//         String key = responseData.keys.toList()[0];
//         super.vendor = Vendor(
//           id: key,
//           name: responseData[key][Datakeys.vendorName],
//           phone: responseData[key][Datakeys.vendorPhone],
//           pos: responseData[key][Datakeys.vendorPos],
//           companyName: responseData[key][Datakeys.vendorCompanyName],
//           companyAddress: responseData[key][Datakeys.vendorCompanyAddress],
//           username: responseData[key][Datakeys.vendorUsername],
//           address: responseData[key][Datakeys.vendorAddress],
//           verified: responseData[key][Datakeys.vendorVerified],
//           rate: responseData[key][Datakeys.vendorRate],
//           rating: responseData[key][Datakeys.vendorRating],
//           dateCreated: responseData[key][Datakeys.vendorDateCreated]
//         );
//       } else{
//         super.vendor = Vendor(
//           id: prefs.getString(Datakeys.vendorId),
//           name: prefs.getString(Datakeys.vendorName),
//           phone: prefs.getString(Datakeys.vendorPhone),
//           pos: json.decode(prefs.getString(Datakeys.vendorPos)),
//           companyName: prefs.getString(Datakeys.vendorCompanyName),
//           companyAddress: prefs.getString(Datakeys.vendorCompanyAddress),
//           username: prefs.getString(Datakeys.vendorUsername),
//           address: prefs.getString(Datakeys.vendorAddress),
//           dateCreated: prefs.getString(Datakeys.vendorDateCreated));
//       }
//     }
//     return true;
//   }

//   Future<bool> _addUser(
//       Map<String, dynamic> userData, String collectionName, String userId) async {
//     toggleLoading(true);
//     try {
//       Geolocator geolocator = Geolocator();
//         Position position = await geolocator
//           .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//       List<double> pos = [position.latitude, position.longitude];
//       userData[collectionName.substring(0, collectionName.length - 1) + "Pos"] = pos;

//       final http.Response response = await http.post(
//           "$_dbUrl/$collectionName/$userId.json?auth=${_authenticatedUser.token}",
//           body: json.encode(userData));
//       if (response.statusCode != 200 && response.statusCode != 201) {
//         toggleLoading(false);
//         return false;
//       }
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       if (collectionName == "clients") {
//         _client = Client(
//             id: responseData['name'],
//             name: userData[Datakeys.clientName],
//             pos: pos,
//             phone: userData[Datakeys.clientPhone],
//             username: userData[Datakeys.clientUsername],
//             address: userData[Datakeys.clientAddress],
//             dateCreated: userData[Datakeys.clientDateCreated]);
//         print(json.encode(_client.toMap()));
//       } else {
//         super.vendor = Vendor(
//             id: responseData['name'],
//             name: userData[Datakeys.vendorName],
//             pos: pos,
//             companyName: userData[Datakeys.vendorCompanyName],
//             companyAddress: userData[Datakeys.vendorCompanyAddress],
//             phone: userData[Datakeys.vendorPhone],
//             username: userData[Datakeys.vendorUsername],
//             address: userData[Datakeys.vendorAddress],
//             verified: userData[Datakeys.vendorVerified],
//             rate: userData[Datakeys.vendorRating],
//             rating: userData[Datakeys.vendorRating],
//             dateCreated: userData[Datakeys.vendorDateCreated]);
//       }
//       userData['id'] = responseData['name'];
//       await _saveUserData(userData);
//       toggleLoading(false);
//       return true;
//     } catch (error) {
//       toggleLoading(false);
//       print(error);
//       return false;
//     }
//   }

//   Future<bool> updateUser(Map<String, dynamic> userData, String collectionName) async{
//     try {
//       final http.Response response = await http.post(
//           "$_dbUrl/$collectionName/${collectionName == 'clients' ? _client.id : super.vendor.id}.json?auth=${_authenticatedUser.token}",
//           body: json.encode(userData));
//       if (response.statusCode != 200 && response.statusCode != 201) {
//         toggleLoading(false);
//         return false;
//       }
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       if (collectionName == "clients") {
//         _client = Client(
//             id: responseData['name'],
//             name: userData[Datakeys.clientName],
//             phone: userData[Datakeys.clientPhone],
//             username: userData[Datakeys.clientUsername],
//             address: userData[Datakeys.clientAddress],
//             dateCreated: userData[Datakeys.clientDateCreated]);
//         print(json.encode(_client.toMap()));
//       } else {
//         super.vendor = Vendor(
//             id: responseData['name'],
//             name: userData[Datakeys.vendorName],
//             companyName: userData[Datakeys.vendorCompanyName],
//             companyAddress: userData[Datakeys.vendorCompanyAddress],
//             phone: userData[Datakeys.vendorPhone],
//             username: userData[Datakeys.vendorUsername],
//             address: userData[Datakeys.vendorAddress],
//             dateCreated: userData[Datakeys.vendorDateCreated]);
//       }
//       userData['id'] = responseData['name'];
//       await _saveUserData(userData);
//       toggleLoading(false);
//       return true;
//     } catch (error) {
//       toggleLoading(false);
//       print(error);
//       return false;
//     }
//   }
  
//   Future<Map<String, dynamic>> signup(String email, String password,
//       {Client client, Vendor vendor}) async {
//     // final Map<String, dynamic> authData =
//     toggleLoading(true);

//     final http.Response response = await http.post(
//         "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=${_apiKey}",
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(
//             {'email': email, 'password': password, 'returnSecureToken': true}));

//     // _isLoading = false;
//     // notifyListeners();

//     final Map<String, dynamic> responseData = json.decode(response.body);
//     bool success = false;
//     String message = 'Authentication Success';
//     if (responseData.containsKey('idToken')) {
//       bool userAdded = false;
//       if (vendor == null) {
//         await _saveAuthUser(responseData, UserType.Client);
//         userAdded = await _addUser(client.toMap(), 'clients', _authenticatedUser.id);
//       } else {
//         await _saveAuthUser(responseData, UserType.Vendor);
//         userAdded = await _addUser(vendor.toMap(), 'vendors', _authenticatedUser.id);
//       }
//       success = userAdded;
//       if (!success) message = 'Failed to upload user data';
//     } else {
//       switch (responseData['error']['message']) {
//         case 'EMAIL_EXISTS':
//           message = 'Your email already exists';
//           break;

//         case 'INVALID_EMAIL':
//           message = 'Your email is invalid';
//           break;

//         default:
//           message = 'Something went wrong';
//           print(responseData['error']['message']);
//           break;
//       }
//     }

//     toggleLoading(false);
//     return {'success': success, 'message': message};
//   }

//   Future<Map<String, dynamic>> login(String email, String password, UserType userType) async {
//     toggleLoading(true);

//     final http.Response response = await http.post(
//         "https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=$_apiKey",
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(
//             {'email': email, 'password': password, 'returnSecureToken': true}));

//     // FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(
//     //   email: email,
//     //   password: password
//     // );
//     // .catchError((e){
//     //   print(e);
//     //   // print(e['message']);
//     //   // print(json.encode(e));
//     // });

//     print(json.encode(user.toString()));

//     final Map<String, dynamic> responseData = json.decode(response.body);
//     bool success = false;
//     String message = 'Authentication Success';
//     int code = -1;
//     if (responseData.containsKey('idToken')) {
//     // if(user.){
//       await _saveAuthUser(responseData, userType);
//       await _getUserData(); //! prevent login if data not saved locally
//       success = true;
//     } else {
//       switch (responseData['error']['message']) {
//         case 'EMAIL_NOT_FOUND':
//           message = 'Your email is not registered';
//           code = 0;
//           break;

//         case 'INVALID_PASSWORD':
//           message = 'Your password is invalid';
//           code = 1;
//           break;

//         case 'USER_DISABLED':
//           message = 'Your account has been disabled';
//           code = 2;
//           break;

//         default:
//           message = 'Something went wrong';
//           print(responseData['error']['message']);
//           break;
//       }
//     }

//     toggleLoading(false);

//     return {'success': success, 'message': message, 'code': code};
//   }

//   Future<bool> logout() async{
//     _authenticatedUser = null;
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('token');
//     prefs.remove('userEmail');
//     prefs.remove('userId');
//     return true;
//   }
  
//   void fetchVendors() {
//     toggleLoading(true);

//     http.get('$_dbUrl/vendors.json').then((http.Response response) {
//       final List<Vendor> fetchedVendorList = [];
//       final Map<String, dynamic> vendorListData = json.decode(response.body);
//       if (vendorListData != null) {
//         vendorListData.forEach((String vendorId, dynamic vendorData) {
//           final Vendor product = Vendor(
//             id: vendorId,
//             name: vendorData['name'],
//             companyName: vendorData[Datakeys.vendorCompanyName],
//             companyAddress: vendorData[Datakeys.vendorCompanyAddress],
//             phone: vendorData['phone'],
//             username: vendorData['username'],
//             address: vendorData['address'],
//             dateCreated: vendorData['dateCreated'],
//             rating: vendorData['rating'],
//             rate: vendorData['rate'],
//             verified: vendorData['verified'],
//           );
//           fetchedVendorList.add(product);
//         });
//         super.vendors = fetchedVendorList;
//       }
//       toggleLoading(false);
//     }).timeout(Duration(seconds: _httpTimeout), onTimeout: () {
//       toggleLoading(false);
//     });
//   }
// }