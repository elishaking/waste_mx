class VendorTransaction {
  final bool pending;
  final String type;
  final String clientId;
  final String clientName;
  final String amount;

  VendorTransaction(
      {this.pending, this.type, this.clientId, this.clientName, this.amount});
}

class Wallet{
  final String id;
  final String fullname;
  final String email;
  final String password;

  Wallet({this.id, this.fullname, this.email, this.password});

  Map<String, dynamic> toMap(){
    return {
      "fullname": fullname,
      "email": email,
      "password": password
    };
  }
}
