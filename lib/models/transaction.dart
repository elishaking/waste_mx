class TransactionType{
  static final String wallet = "Wallet Transaction";
  static final String dispose = "Dispose Waste";
  static final String recycle = "Recycle Waste";
  static final String decluster = "De-cluster";
}

// class TransactionSubType{
//   static final String household = "Household Waste";
// }

class VendorTransaction {
  final bool pending;
  final String type;
  final String subType;
  final String clientId;
  final String clientName;
  final String amount;

  VendorTransaction(
      {this.pending, this.type, this.subType, this.clientId, this.clientName, this.amount});
}

class ClientTransaction {
  final bool pending;
  final String type;
  final String subType;
  final String vendorId;
  final String vendorName;
  final String amount;

  ClientTransaction(
      {this.pending, this.type, this.subType, this.vendorId, this.vendorName, this.amount});
}

class Wallet{
  final String id;
  final String fullname;
  final String email;
  final String refId;
  final int balance;
  final List transactions;
  final String localCurrency;

  Wallet({this.balance, this.transactions, this.localCurrency, this.id, this.fullname, this.email, this.refId});

  Map<String, dynamic> toMap(){
    return {
      "fullname": fullname,
      "email": email,
      "refId": refId
    };
  }
}

class CardDetails{
  String name;
  String number;
  String expiryDate;
  String cvv;

  CardDetails({this.name, this.number, this.expiryDate, this.cvv});

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "number": number,
      "expiryDate": expiryDate,
      "cvv": cvv
    };
  }
}

class PaystackSubAccount{
  String businessName;
  String settlementBank;
  String accountNumber;
  double percentageCharge;
  String primaryContactEmail;
  String primaryContactName;
  String primaryContactPhone;

  PaystackSubAccount({this.businessName, this.settlementBank, this.accountNumber, this.percentageCharge, this.primaryContactEmail, this.primaryContactName, this.primaryContactPhone});

  Map<String, dynamic> toMap(){
    return {
      "business_name": this.businessName,
      "settlement_bank": this.settlementBank,
      "account_number": this.accountNumber,
      "percentage_charge": this.percentageCharge,
      "primary_contact_email": this.primaryContactEmail,
      "primary_contact_name": this.primaryContactName,
      "primary_contact_phone": this.primaryContactPhone
    };
  }

  PaystackSubAccount.fromMap(Map<String, dynamic> data){
    businessName = data["business_name"];
    settlementBank = data["settlement_bank"];
    accountNumber = data["account_number"];
    percentageCharge = data["percentage_charge"];
    primaryContactEmail = data["primary_contact_email"];
    primaryContactName = data["primary_contact_name"];
    primaryContactPhone = data["primary_contact_phone"];
  }
}
