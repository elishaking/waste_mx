class DisposeWasteType {
  static const String householdWaste = "Household Waste";
  static const String industrialWaste = "Industrial Waste";
  static const String agricWaste = "Agric Waste";
  static const String bulkWaste = "Bulk Waste";
  static const String nuclearWaste = "Nuclear Waste";
  static const String otherWaste = "Other Waste";
}

class DisposeOffering {
  final String id;
  final String name;
  final String iconUrl;
  final List<dynamic> imageUrls;
  final String price;
  final String rate;
  final String numberOfBins;
  final String clientName;
  final String clientLocation;
  final String date;
  final String userId;
  final List<dynamic> imagePaths;

  DisposeOffering(
      {this.id,
      this.name,
      this.iconUrl,
      this.imageUrls,
      this.price,
      this.rate,
      this.numberOfBins,
      this.clientName,
      this.clientLocation,
      this.date,
      this.userId,
      this.imagePaths});
}
