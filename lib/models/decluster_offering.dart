class DeclusterType {
  static const String vehicles = "Vehicles";
  static const String bottles = "Bottles";
  static const String clothes = "Clothes";
  static const String appliances = "Appliances";
  static const String furniture = "Furniture";
  static const String household = "Household";
  static const String stationery = "Stationery";
}

class DeclusterOffering {
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

  DeclusterOffering(
    {
      this.id,
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
      this.imagePaths
    }
  );
}