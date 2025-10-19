import 'package:flutter/foundation.dart';
import '../../data/models/order/order_model.dart';

class OrderService {
  // Singleton pattern
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final List<Order> _orders = [];

  /// Returns an unmodifiable list of all orders (most recent first)
  List<Order> get orders => List.unmodifiable(_orders);

  /// Adds a new order to the list (inserts at top)
  void addOrder(Order order) {
    _orders.insert(0, order);
    if (kDebugMode) {
      print(
        '✅ Order added: ${order.id}, total: \$${order.totalAmount.toStringAsFixed(2)}',
      );
    }
  }

  /// Finds and returns an order by ID, or null if not found
  Order? getOrderById(String orderId) {
    for (final order in _orders) {
      if (order.id == orderId) {
        return order;
      }
    }
    return null; // Explicitly return null if not found
  }
}
