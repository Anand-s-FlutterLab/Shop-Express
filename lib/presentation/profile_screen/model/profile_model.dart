class ProfileModel {
  String profileOption;
  String imageAddress;

  ProfileModel({
    required this.profileOption,
    required this.imageAddress,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      profileOption: json['profileOption'],
      imageAddress: json['imageAddress'],
    );
  }
}
