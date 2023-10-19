import 'package:get/get.dart';

class CreditCardDetails {
  String cardNumber;
  String expiryDate;
  String cvv;
  String name;
  RxBool showBack = false.obs;

  CreditCardDetails({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
    required this.name,
  });

  factory CreditCardDetails.fromJson(Map<String, dynamic> json) {
    return CreditCardDetails(
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'name': name,
    };
  }
}
