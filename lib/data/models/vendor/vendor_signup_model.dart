class VendorSignupModel {
  final int id;
  final String restaurantName;
  final String email;
  final String password;

  VendorSignupModel({
    required this.id,
    required this.restaurantName,
    required this.email,
    required this.password,
  });

  factory VendorSignupModel.fromJson(Map<String, dynamic> json) {
    return VendorSignupModel(
      id: json['id'],
      restaurantName: json['restaurantName'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'email': email,
      'password': password,
    };
  }
}
