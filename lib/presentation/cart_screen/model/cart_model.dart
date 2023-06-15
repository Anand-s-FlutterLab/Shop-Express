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
}
