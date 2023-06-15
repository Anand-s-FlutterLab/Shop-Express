class SignUpModel {
  String firstName;
  String lastName;
  String emailAddress;

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      "First Name": firstName,
      "Last Name": lastName,
      "Email Address": emailAddress,
    };
  }
}
