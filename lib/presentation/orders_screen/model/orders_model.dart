import 'package:shopexpress/presentation/cart_screen/model/cart_model.dart';
import 'package:shopexpress/presentation/saved_address_screen/model/saved_address_model.dart';

class OrderModel {
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
  int orderTotal;
  String appliedCoupon;

  OrderModel({
    required this.totalItems,
    required this.subTotal,
    required this.shippingCharges,
    required this.taxes,
    required this.paymentMethod,
    required this.transactionId,
    required this.expectedDeliveryDate,
    required this.orderStatus,
    required this.items,
    required this.deliveryAddress,
    required this.orderID,
    required this.orderDate,
    required this.orderTotal,
    required this.appliedCoupon,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'];
    List<CartItem> items =
        itemsJson.map((itemJson) => CartItem.fromJson(itemJson)).toList();
    SavedAddress deliveryAddress =
        SavedAddress.fromJson(json['deliveryAddress']);

    return OrderModel(
      totalItems: json['totalItems'],
      subTotal: json['subTotal'],
      shippingCharges: double.parse(json['shippingCharges'].toString()),
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

    return {
      'totalItems': totalItems,
      'subTotal': subTotal,
      'shippingCharges': shippingCharges,
      'taxes': taxes,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
      'expectedDeliveryDate': expectedDeliveryDate,
      'orderStatus': orderStatus,
      'items': itemsJson,
      'deliveryAddress': deliveryAddress.toJson(),
      'orderID': orderID,
      'orderDate': orderDate,
      'orderTotal': orderTotal,
      'appliedCoupon': appliedCoupon,
    };
  }
}
