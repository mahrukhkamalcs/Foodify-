import '../cart/cart_item_model.dart';

class Order {
  final String id;
  final String restaurantName;
  final String status; // 'Placed', 'Preparing', etc.
  final String estimatedDeliveryTime;
  final double totalAmount;
  final DateTime orderTime;
  final List<CartItemModel> items;

  Order({
    required this.id,
    required this.restaurantName,
    required this.status,
    required this.estimatedDeliveryTime,
    required this.totalAmount,
    required this.orderTime,
    this.items = const [],
  });

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  // ✅ fromJson
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      restaurantName: json['restaurantName'] as String,
      status: json['status'] as String,
      estimatedDeliveryTime: json['estimatedDeliveryTime'] as String,
      totalAmount: (json['totalAmount'] as num).toDouble(),
      orderTime: DateTime.parse(json['orderTime'] as String),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // ✅ toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'status': status,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'totalAmount': totalAmount,
      'orderTime': orderTime.toIso8601String(),
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
