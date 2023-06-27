import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CartItem {
  final String productId;
  final String productName;
  final String productBrand;
  final double productDisplayPrice;
  final String displayImageLink;
  RxInt productQuantity;
  RxDouble productFinalPrice = 0.0.obs;
  TextEditingController cartQuantityController = TextEditingController();

  CartItem({
    required this.productId,
    required this.productName,
    required this.productDisplayPrice,
    required this.productQuantity,
    required this.productBrand,
    required this.displayImageLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productBrand': productBrand,
      'productDisplayPrice': productDisplayPrice,
      'displayImageLink': displayImageLink,
      'productQuantity': productQuantity.value,
      'productFinalPrice': productFinalPrice.value,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      productName: json['productName'],
      productBrand: json['productBrand'],
      productDisplayPrice: double.parse(json['productFinalPrice'].toString()),
      displayImageLink: json['displayImageLink'],
      productQuantity: RxInt(
        json['productQuantity'],
      ),
    );
  }
}
