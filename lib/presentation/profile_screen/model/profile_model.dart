class ProfileModel {
  String profileOption;
  String imageAddress;
  String route;

  ProfileModel({
    required this.profileOption,
    required this.imageAddress,
    required this.route,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileOption: json['profileOption'] ?? '',
      imageAddress: json['imageAddress'] ?? '',
      route: json['route'] ?? '',
    );
  }
}
