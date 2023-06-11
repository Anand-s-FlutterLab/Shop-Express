class ManageItemSliderModel {
  String productName;
  String productId;
  String productImage;

  ManageItemSliderModel({
    required this.productName,
    required this.productId,
    required this.productImage,
  });

  // Convert the model object to a JSON format
  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productId': productId,
      'productImage': productImage,
    };
  }

  // Create a factory method to parse JSON and create an instance of the model class
  factory ManageItemSliderModel.fromJson(Map<String, dynamic> json) {
    return ManageItemSliderModel(
      productName: json['productName'],
      productId: json['productId'],
      productImage: json['productImage'],
    );
  }
}
