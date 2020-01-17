class TransactionType{
  static final String wallet = "Wallet Transaction";
  static final String dispose = "Dispose Waste";
  static final String recycle = "Recycle Waste";
  static final String decluster = "De-cluster";
}

class TransactionSubType{
  static final String credit = "Credit Wallet";
}

class Transaction{
  final bool pending;
  final String type;
  final String subType;
  final double amount;
  final bool initiatedByVendor;
  final bool initiatedByClient;
  final VendorDetails vendorDetails;
  final ClientDetails clientDetails;

  Transaction({this.pending, this.type, this.subType, this.amount, this.initiatedByVendor, this.initiatedByClient, this.vendorDetails, this.clientDetails});

  Map<String, dynamic> toMap(){
    return {
      "pending": pending,
      "type": type,
      "subType": subType,
      "amount": amount,
      "initiatedByVendor": initiatedByVendor,
      "initiatedByClient": initiatedByClient,
      "vendorDetails": vendorDetails.toMap(),
      "clientDetails": clientDetails.toMap()
    };
  }

  static Transaction fromMap(Map<String, dynamic> data){
    return Transaction(
      pending: data["pending"],
      type: data["type"],
      subType: data["subType"],
      amount: data["amount"],
      initiatedByVendor: data["initiatedByVendor"],
      initiatedByClient: data["initiatedByClient"],
      clientDetails: ClientDetails.fromMap(data["clientDetails"]),
      vendorDetails: VendorDetails.fromMap(data["vendorDetails"])
    );
    // pending = data["pending"];
    // type = data["type"];
    // subType = data["subType"];
    // amount = data["amount"];
    // initiatedByVendor = data["initiatedByVendor"];
    // initiatedByClient = data["initiatedByClient"];
    // vendorDetails = data["vendorDetails"];
    // clientDetails = data["clientDetails"];
  }
}

class VendorDetails {
  final String vendorId;
  final String vendorName;

  VendorDetails({this.vendorId, this.vendorName});

  Map<String, dynamic> toMap(){
    return {
      "vendorId": vendorId,
      "vendorName": vendorName
    };
  }

  static VendorDetails fromMap(Map<String, dynamic> data){
    return VendorDetails(
      vendorId: data["vendorId"],
      vendorName: data["vendorName"]
    );
  }
}

class ClientDetails {
  final String clientId;
  final String clientName;

  ClientDetails({this.clientId, this.clientName});

  Map<String, dynamic> toMap(){
    return {
      "clientId": clientId,
      "clientName": clientName
    };
  }

  static ClientDetails fromMap(Map<String, dynamic> data){
    return ClientDetails(
      clientId: data["clientId"],
      clientName: data["clientName"]
    );
  }
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

class Escrow{
  final String id;
  final double amount;

  Escrow({this.id, this.amount});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "amount": amount
    };
  }

  static Escrow fromMap(Map<String, dynamic> data){
    return Escrow(
      id: data["id"],
      amount: data["amount"]
    );
  }
}
