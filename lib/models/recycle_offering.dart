class RecycleWasteType {
  static const String plastics = "Plastics";
  static const String metals = "Metals";
  static const String glass = "Glass";
  static const String paper = "Paper";
  static const String nuclear = "Nuclear";
  static const String otherWaste = "Other Waste";
}

class RecycleOffering {
  final String id;
  final String name;
  final String iconUrl;
  final List<dynamic> imageUrls;
  final String price;
  final String rate;
  final String weight;
  final String clientName;
  final String clientLocation;
  final String date;
  final String userId;
  final List<dynamic> imagePaths;

  RecycleOffering(
      {this.id,
      this.name,
      this.iconUrl,
      this.imageUrls,
      this.price,
      this.rate,
      this.weight,
      this.clientName,
      this.clientLocation,
      this.date,
      this.userId,
      this.imagePaths});
}
