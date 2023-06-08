class SearchProductModel {
  final String productName;
  final String productBrand;
  final String productId;
  final double productPrice;
  final double productDiscount;
  final double productDisplayPrice;
  final String displayImageLink;

  SearchProductModel({
    required this.productName,
    required this.productBrand,
    required this.productId,
    required this.productPrice,
    required this.productDiscount,
    required this.productDisplayPrice,
    required this.displayImageLink,
  });

  factory SearchProductModel.fromFirestore(Map<String, dynamic> firestoreData) {
    return SearchProductModel(
      productName: firestoreData['productName'],
      productBrand: firestoreData['productBrand'],
      productId: firestoreData['productId'],
      productPrice: firestoreData['productPrice'],
      productDiscount: firestoreData['productDiscount'],
      productDisplayPrice: firestoreData['productDisplayPrice'],
      displayImageLink: firestoreData['displayImageLink'],
    );
  }
}
