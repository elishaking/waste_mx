class VendorTransaction{
  final bool pending;
  final String type;
  final String clientId;
  final String clientName;
  final String amount;

  VendorTransaction({this.pending, this.type, this.clientId, this.clientName, this.amount});
}