class EditProfileModel {
  String firstName;
  String lastName;
  String email;
  int mobileNumber;
  String profileUrl;

  EditProfileModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    int? mobileNumber,
    String? profileUrl,
  })  : mobileNumber = mobileNumber ?? 0,
        profileUrl = profileUrl ?? "";

  EditProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    int? mobileNumber,
    String? profileUrl,
  }) {
    return EditProfileModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      profileUrl: profileUrl ?? this.profileUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Email Address': email,
      'Mobile Number': mobileNumber,
      'Profile URL': profileUrl,
    };
  }

  factory EditProfileModel.fromJson(Map<String, dynamic> json) {
    return EditProfileModel(
      firstName: json['First Name'],
      lastName: json['Last Name'],
      email: json['Email Address'],
      mobileNumber: json['Mobile Number'],
      profileUrl: json['Profile URL'],
    );
  }
}
