class OfferingType {
  static const dispose = 'Dispose Offering';
  static const recycle = 'Recycle Offering';
  static const decluster = 'Decluster Offering';
}

class UploadImageData{
  final String imageUrl;
  final String imagePath;

  UploadImageData({this.imageUrl, this.imagePath});

  Map<String, dynamic> toMap(){
    return {
      "imageUrl": imageUrl,
      "imagePath": imagePath
    };
  }

  static UploadImageData fromMap(Map<String, dynamic> data){
    return UploadImageData(
      imageUrl: data["imageUrl"],
      imagePath: data["imagePath"]
    );
  }
}
