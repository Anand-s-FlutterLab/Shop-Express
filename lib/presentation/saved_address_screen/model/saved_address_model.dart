class SavedAddress {
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String country;
  String postalCode;
  String addressType;
  String mobile;
  String id;

  SavedAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.addressType,
    required this.mobile,
    required this.id,
  });

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    return SavedAddress(
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      postalCode: json['postalCode'],
      addressType: json['addressType'],
      mobile: json['mobile'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'addressType': addressType,
      'mobile': mobile,
      'id': id,
    };
  }
}
