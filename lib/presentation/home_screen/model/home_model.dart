import 'package:get/get.dart';

class ItemSliderModel {
  String productName;
  String productId;
  String productImage;

  ItemSliderModel({
    required this.productName,
    required this.productId,
    required this.productImage,
  });

  factory ItemSliderModel.fromJson(Map<String, dynamic> json) {
    return ItemSliderModel(
      productName: json['productName'],
      productId: json['productId'],
      productImage: json['productImage'],
    );
  }
}

class CategoryImageModel {
  String categoryImage;
  String categoryName;

  CategoryImageModel({
    required this.categoryImage,
    required this.categoryName,
  });

  factory CategoryImageModel.fromJson(Map<String, dynamic> json) {
    return CategoryImageModel(
      categoryName: json['categoryName'],
      categoryImage: json['Image'],
    );
  }
}

class ImageSliderModel {
  String productName;
  String productId;
  String displayImageLink;
  String productBrand;
  double productDisplayPrice;
  final RxBool isFavorite;

  ImageSliderModel({
    required this.productName,
    required this.productId,
    required this.displayImageLink,
    required this.productBrand,
    required this.productDisplayPrice,
    bool isFavorite = false,
  }) : isFavorite = isFavorite.obs;

  factory ImageSliderModel.fromJson(Map<String, dynamic> json) {
    return ImageSliderModel(
      productName: json['productName'],
      productId: json['productId'],
      displayImageLink: json['displayImageLink'],
      productBrand: json['productBrand'],
      productDisplayPrice: json['productDisplayPrice'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
