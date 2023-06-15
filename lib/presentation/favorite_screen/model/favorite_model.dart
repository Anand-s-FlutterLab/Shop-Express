class FavoriteModel {
  final String productName;
  final String productBrand;
  final String productId;
  final double productPrice;
  final double productDiscount;
  final double productDisplayPrice;
  final String displayImageLink;

  FavoriteModel({
    required this.productName,
    required this.productBrand,
    required this.productId,
    required this.productPrice,
    required this.productDiscount,
    required this.productDisplayPrice,
    required this.displayImageLink,
  });
}
