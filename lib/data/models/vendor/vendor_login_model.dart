class VendorLoginModel {
  final int id;
  final String email;
  final String password;

  VendorLoginModel({
    required this.id,
    required this.email,
    required this.password,
  });

  factory VendorLoginModel.fromJson(Map<String, dynamic> json) {
    return VendorLoginModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}
