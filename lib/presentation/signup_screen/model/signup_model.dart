import 'package:shopexpress/core/app_export.dart';

class SignUpModel {
  String firstName;
  String lastName;
  String emailAddress;
  String profileURL;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    String? profileURL,
  }) : profileURL = profileURL ?? defaultProfileImage;

  Map<String, dynamic> toJson() {
    return {
      "First Name": firstName,
      "Last Name": lastName,
      "Email Address": emailAddress,
      "Profile URL": profileURL,
    };
  }
}
