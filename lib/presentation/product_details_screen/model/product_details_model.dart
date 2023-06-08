class ProductDetailsModel {
  final String productId;
  final String productName;
  final String productBrand;
  final String productCategory;
  final String productDescription;
  final double productPrice;
  final double productDiscount;
  final double productDisplayPrice;
  final String displayImageLink;
  final List<String> productImages;
  final Map<String, String> productDetails;

  ProductDetailsModel({
    required this.productId,
    required this.productName,
    required this.productBrand,
    required this.productCategory,
    required this.productDescription,
    required this.productPrice,
    required this.productDiscount,
    required this.productDisplayPrice,
    required this.displayImageLink,
    required this.productImages,
    required this.productDetails,
  });

  factory ProductDetailsModel.fromFirestore(
      Map<String, dynamic> firestoreData) {
    return ProductDetailsModel(
      productId: firestoreData['productId'],
      productName: firestoreData['productName'],
      productBrand: firestoreData['productBrand'],
      productCategory: firestoreData['productCategory'],
      productDescription: firestoreData['productDescription'],
      productPrice: firestoreData['productPrice'],
      productDiscount: firestoreData['productDiscount'],
      productDisplayPrice: firestoreData['productDisplayPrice'],
      displayImageLink: firestoreData['displayImageLink'],
      productImages: List<String>.from(firestoreData['productImages']).reversed.toList(),
      productDetails: Map<String, String>.from(firestoreData['productDetails']),
    );
  }
}
