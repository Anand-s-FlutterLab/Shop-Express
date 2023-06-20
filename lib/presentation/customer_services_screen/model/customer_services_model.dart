class CustomerSupportModel {
  String imageAddress;
  String email;
  String mobileNumber;

  CustomerSupportModel({
    required this.imageAddress,
    required this.email,
    required this.mobileNumber,
  });

  factory CustomerSupportModel.fromJson(Map<String, dynamic> json) {
    return CustomerSupportModel(
      imageAddress: json['imageAddress'],
      email: json['email'],
      mobileNumber: json['mobile'],
    );
  }
}
