enum PaymentType {
  card,
  cash,
  wallet,
}

class PaymentMethodModel {
  final String id;
  final PaymentType type;
  final String displayName;
  final String? cardNumber; // Last 4 digits
  final String? cardType; // Visa, Mastercard, etc.
  final String? expiryDate;
  final bool isDefault;

  PaymentMethodModel({
    required this.id,
    required this.type,
    required this.displayName,
    this.cardNumber,
    this.cardType,
    this.expiryDate,
    this.isDefault = false,
  });

  String get displayInfo {
    switch (type) {
      case PaymentType.card:
        return '•••• $cardNumber';
      case PaymentType.cash:
        return 'Pay with cash on delivery';
      case PaymentType.wallet:
        return 'Digital wallet';
    }
  }
}