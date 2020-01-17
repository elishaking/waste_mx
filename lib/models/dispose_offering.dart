import 'package:waste_mx/models/offering.dart';

class DisposeWasteType {
  static const String householdWaste = "Household Waste";
  static const String industrialWaste = "Industrial Waste";
  static const String agricWaste = "Agric Waste";
  static const String bulkWaste = "Bulk Waste";
  static const String nuclearWaste = "Nuclear Waste";
  static const String otherWaste = "Other Waste";
}

class DisposeOffering {
  String id;
  final String name;
  final String iconUrl;
  List<UploadImageData> imageData;
  final String price;
  final String rate;
  final String numberOfBins;
  final String clientId;
  final String clientName;
  final String clientLocation;
  final String date;

  DisposeOffering(
      {this.id,
      this.name,
      this.iconUrl,
      this.imageData,
      this.price,
      this.rate,
      this.numberOfBins,
      this.clientId,
      this.clientName,
      this.clientLocation,
      this.date});

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "name": name,
      "iconUrl": iconUrl,
      "imageData": imageData.map((UploadImageData data) => data.toMap()).toList(),
      "price": price,
      "rate": rate,
      "numberOfBins": numberOfBins,
      "clientId": clientId,
      "clientName": clientName,
      "clientLocation": clientLocation,
      "date": date,
    };
  }

  static DisposeOffering fromMap(Map<String, dynamic> data){
    return DisposeOffering(
      id: data["id"],
      name: data["name"],
      imageData: data["imageData"].map((imgData) => UploadImageData.fromMap(imgData)).toList(),
      iconUrl: data["iconUrl"],
      price: data["price"],
      rate: data["rate"],
      numberOfBins: data["numberOfBins"],
      clientId: data["clientId"],
      clientName: data["clientName"],
      clientLocation: data["clientLocation"],
      date: data["date"],
    );
  }
}
