class LoginModel {
  String firstName;
  String lastName;
  String email;
  bool isAdmin;

  LoginModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    bool? isAdmin,
  }) : isAdmin = isAdmin ?? false;

  Map<String, dynamic> toJson() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'Email Address': email,
      'isAdmin': isAdmin,
    };
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      firstName: json['First Name'],
      lastName: json['Last Name'],
      email: json['Email Address'],
      isAdmin: json['isAdmin'],
    );
  }
}
