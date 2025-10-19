import '../cart/cart_item_model.dart';

class Order {
  final String id;
  final String restaurantName;
  final String status; // e.g., 'Placed', 'Preparing', 'On the Way', 'Delivered'
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
    this.items =
        const [], // ✅ Optional with default empty list (safer approach)
  });

  // Helper to get item count
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  // Optional: Add fromJson / toJson if using API later
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'status': status,
      'estimatedDeliveryTime': estimatedDeliveryTime,
      'totalAmount': totalAmount,
      'orderTime': orderTime.toIso8601String(),
      'items':
          items
              .map(
                (item) => {
                  'menuItemId': item.menuItem.id,
                  'name': item.menuItem.name,
                  'imageUrl': item.menuItem.imageUrl,
                  'price': item.menuItem.price,
                  'quantity': item.quantity,
                },
              )
              .toList(),
    };
  }
}
