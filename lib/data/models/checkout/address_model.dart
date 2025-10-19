class AddressModel {
  final String id;
  final String label; // Home, Work, Other
  final String fullAddress;
  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String? apartment;
  final String? instructions;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.label,
    required this.fullAddress,
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    this.apartment,
    this.instructions,
    this.isDefault = false,
  });

  AddressModel copyWith({
    String? id,
    String? label,
    String? fullAddress,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? apartment,
    String? instructions,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      label: label ?? this.label,
      fullAddress: fullAddress ?? this.fullAddress,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      apartment: apartment ?? this.apartment,
      instructions: instructions ?? this.instructions,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
