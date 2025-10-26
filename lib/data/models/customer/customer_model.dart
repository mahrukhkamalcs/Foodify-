class CustomerModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String address;
  final String city;
  final String country;

  CustomerModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
    required this.city,
    required this.country,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }
}
