class Coupons {
  String couponName;
  String description;
  int minimumOrderAmount;
  int couponDiscountPercentage;
  String color1;
  String color2;

  Coupons({
    required this.couponName,
    required this.description,
    required this.minimumOrderAmount,
    required this.couponDiscountPercentage,
    required this.color1,
    required this.color2,
  });

  factory Coupons.fromJson(Map<String, dynamic> json) {
    return Coupons(
      couponName: json['couponName'],
      description: json['description'],
      minimumOrderAmount: json['minimumOrderAmount'],
      couponDiscountPercentage: json['couponDiscountPercentage'],
      color1: json['color1'],
      color2: json['color2'],
    );
  }
}