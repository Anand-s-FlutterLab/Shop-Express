class ManageProductModel {
  final String productName;
  final String productId;
  final String displayImageLink;

  ManageProductModel({
    required this.productName,
    required this.productId,
    required this.displayImageLink,
  });

  factory ManageProductModel.fromFirestore(Map<String, dynamic> firestoreData) {
    return ManageProductModel(
      productName: firestoreData['productName'],
      productId: firestoreData['productId'],
      displayImageLink: firestoreData['displayImageLink'],
    );
  }
}
