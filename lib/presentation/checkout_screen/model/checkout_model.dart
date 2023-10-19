import 'dart:math';

import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/core/Utils/date_time.dart';
import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/saved_address_screen/model/saved_address_model.dart';

class CheckoutModel {
  int totalItems;
  double subTotal;
  double shippingCharges;
  double taxes;
  String paymentMethod;
  String transactionId;
  String expectedDeliveryDate;
  String orderStatus;
  List<CartItem> items;
  SavedAddress deliveryAddress;
  String orderID;
  String orderDate;
  double orderTotal;
  String appliedCoupon;

  CheckoutModel({
    required this.totalItems,
    required this.subTotal,
    required this.shippingCharges,
    required this.taxes,
    required this.paymentMethod,
    this.transactionId = '',
    this.expectedDeliveryDate = '',
    required this.orderStatus,
    required this.items,
    required this.deliveryAddress,
    this.orderID = '',
    this.orderDate = '',
    required this.orderTotal,
    required this.appliedCoupon,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'];
    List<CartItem> items =
        itemsJson.map((itemJson) => CartItem.fromJson(itemJson)).toList();
    SavedAddress deliveryAddress =
        SavedAddress.fromJson(json['deliveryAddress']);

    return CheckoutModel(
      totalItems: json['totalItems'],
      subTotal: json['subTotal'],
      shippingCharges: json['shippingCharges'],
      taxes: json['taxes'],
      paymentMethod: json['paymentMethod'],
      transactionId: json['transactionId'],
      expectedDeliveryDate: json['expectedDeliveryDate'],
      orderStatus: json['orderStatus'],
      items: items,
      deliveryAddress: deliveryAddress,
      orderID: json['orderID'],
      orderTotal: json['orderTotal'],
      orderDate: json['orderDate'],
      appliedCoupon: json['appliedCoupon'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();
    final orderID = Random().nextInt(900000) + 100000;
    final transactionID = Random().nextInt(900000) + 100000;

    return {
      'totalItems': totalItems,
      'subTotal': subTotal,
      'shippingCharges': shippingCharges,
      'taxes': taxes,
      'paymentMethod': paymentMethod,
      'transactionId': "SETI$transactionID",
      'expectedDeliveryDate':
          dateFormatter(dateFormat: dateFormatWithDay, deliveryDelay: 5),
      'orderStatus': orderStatus,
      'items': itemsJson,
      'deliveryAddress': deliveryAddress.toJson(),
      'orderID': "SEOS$orderID",
      'orderDate': dateFormatter(dateFormat: dateFormatWithDayAndTime),
      'orderTotal': orderTotal,
      'appliedCoupon': appliedCoupon,
    };
  }
}

class CheckoutImages {
  String checkoutCategory;
  String imageUrl;

  CheckoutImages({
    required this.imageUrl,
    required this.checkoutCategory,
  });

  factory CheckoutImages.fromJson(Map<String, dynamic> json) {
    return CheckoutImages(
      imageUrl: json['imageUrl'],
      checkoutCategory: json['checkoutCategory'],
    );
  }
}
