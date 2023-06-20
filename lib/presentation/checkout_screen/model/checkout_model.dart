import 'package:shopexpress/core/app_export.dart';
import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/saved_address_screen/model/saved_address_model.dart';

class CheckoutModel {
  int totalItems;
  double subTotal;
  double shippingCharges;
  double taxes;
  String paymentMethod;
  String transactionId;
  DateTime expectedDeliveryDate;
  String orderStatus;
  List<CartItem> items;
  SavedAddress deliveryAddress;
  String orderID;

  CheckoutModel({
    required this.totalItems,
    required this.subTotal,
    required this.shippingCharges,
    required this.taxes,
    required this.paymentMethod,
    this.transactionId = '',
    required this.expectedDeliveryDate,
    required this.orderStatus,
    required this.items,
    required this.deliveryAddress,
    this.orderID = '',
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
      expectedDeliveryDate: DateTime.parse(json['expectedDeliveryDate']),
      orderStatus: json['orderStatus'],
      items: items,
      deliveryAddress: deliveryAddress,
      orderID: json['orderID'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemsJson =
        items.map((item) => item.toJson()).toList();

    return {
      'totalItems': totalItems,
      'subTotal': subTotal,
      'shippingCharges': shippingCharges,
      'taxes': taxes,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'expectedDeliveryDate': expectedDeliveryDate.toIso8601String(),
      'orderStatus': orderStatus,
      'items': itemsJson,
      'deliveryAddress': deliveryAddress.toJson(),
      'orderID': DateTime.now().microsecondsSinceEpoch.toString() +
          userID.value.substring(2, 4),
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
