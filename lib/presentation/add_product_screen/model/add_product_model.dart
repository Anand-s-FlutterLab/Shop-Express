class AddProductModel {
  String productName;
  String productBrand;
  String productCategory;
  String productDescription;
  String productId;
  double productPrice;
  double productDiscount;
  double productDisplayPrice;
  String displayImageLink;
  List<String> productImages;
  Map<String, String> productDetails;

  AddProductModel({
    required this.productName,
    required this.productBrand,
    required this.productCategory,
    required this.productDescription,
    required this.productId,
    required this.productPrice,
    required this.productDiscount,
    required this.productDisplayPrice,
    required this.displayImageLink,
    required this.productImages,
    required this.productDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'productName': productName,
      'productBrand': productBrand,
      'productCategory': productCategory,
      'productDescription': productDescription,
      'productId': productId,
      'productPrice': productPrice,
      'productDiscount': productDiscount,
      'productDisplayPrice': productDisplayPrice,
      'displayImageLink': displayImageLink,
      'productImages': productImages,
      'productDetails': productDetails,
    };
  }

  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return AddProductModel(
      productName: json['productName'],
      productBrand: json['productBrand'],
      productCategory: json['productCategory'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productPrice: json['productPrice'],
      productDiscount: json['productDiscount'],
      productDisplayPrice: json['productDisplayPrice'],
      displayImageLink: json['displayImageLink'],
      productImages: json['productImages'],
      productDetails: json['productDetails'],
    );
  }
}
