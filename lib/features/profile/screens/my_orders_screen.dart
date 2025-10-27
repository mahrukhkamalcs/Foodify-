import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/order/order_model.dart';

class MyOrdersScreen extends StatefulWidget {
  static const routeName = '/my-orders';
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  int userId = -1;
  String userEmail = '';
  String userName = 'Customer';
  List<Order> orders = [];
  bool isLoading = true; // loading spinner while fetching

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('userId') ?? -1;
    final email = prefs.getString('userEmail') ?? '';
    final name = prefs.getString('userName') ?? 'Customer';

    List<Order> loadedOrders = [];
    if (id != -1) {
      final List<String>? savedOrders = prefs.getStringList('orders_$id');
      if (savedOrders != null && savedOrders.isNotEmpty) {
        loadedOrders = savedOrders.map((orderJson) {
          try {
            final Map<String, dynamic> data = jsonDecode(orderJson);
            return Order.fromJson(data); // Make sure Order has fromJson
          } catch (e) {
            return null;
          }
        }).whereType<Order>().toList();
      }
    }

    setState(() {
      userId = id;
      userEmail = email;
      userName = name;
      orders = loadedOrders;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('My Orders')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('My Orders')),
      body: orders.isEmpty
          ? const Center(child: Text('No orders found'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final order = orders[index];
                return ListTile(
                  title: Text('Order #${order.id} - ${order.restaurantName}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('User: $userName ($userEmail)'),
                      Text('Total: \$${order.totalAmount.toStringAsFixed(2)}'),
                      Text('Status: ${order.status}'),
                    ],
                  ),
                  leading: const Icon(Icons.shopping_bag),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, size: 16),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/order-tracking',
                        arguments: {
                          'orderId': order.id,
                          'estimatedDeliveryTime': order.estimatedDeliveryTime,
                        },
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
