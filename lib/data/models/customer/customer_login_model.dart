class CustomerLoginModel {
  final int id;
  final String email;
  final String password;

  CustomerLoginModel({
    required this.id,
    required this.email,
    required this.password,
  });

  factory CustomerLoginModel.fromJson(Map<String, dynamic> json) {
    return CustomerLoginModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
    );
  }
}
