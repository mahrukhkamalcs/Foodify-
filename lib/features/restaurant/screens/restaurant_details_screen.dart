import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/cart/cart_item_model.dart';
import 'package:flutter_application_1/data/models/restaurant/menu_item_model.dart';
import 'package:flutter_application_1/data/models/restaurant/restaurant_model.dart';
import 'package:flutter_application_1/features/checkout/checkout_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsScreen({
    super.key,
    required this.restaurant,
  });

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  final Map<int, int> cart = {}; // itemId -> quantity
  List<MenuItemModel> menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  // Load menu from SharedPreferences + original menu
  Future<void> _loadMenuItems() async {
    List<MenuItemModel> combinedMenu = List.from(widget.restaurant.menu);

    final prefs = await SharedPreferences.getInstance();
    final String? existingJson = prefs.getString('vendor_restaurants');

    if (existingJson != null) {
      final List<dynamic> restaurants = json.decode(existingJson);

      final restaurantData = restaurants.firstWhere(
          (r) => r['id'].toString() == widget.restaurant.id.toString(),
          orElse: () => null);

      if (restaurantData != null && restaurantData['menu'] != null) {
        final vendorMenu = List<MenuItemModel>.from(
          (restaurantData['menu'] as List<dynamic>)
              .map((e) => MenuItemModel.fromJson(e)),
        );
        combinedMenu.addAll(vendorMenu);
      }
    }

    setState(() {
      menuItems = combinedMenu;
    });
  }

  double get totalPrice {
    double sum = 0.0;
    cart.forEach((key, value) {
      final item = menuItems.firstWhere(
        (i) => i.id == key,
        orElse: () => MenuItemModel(
          id: -1,
          name: 'Unknown',
          imageUrl: '',
          description: '',
          price: 0.0,
          restaurantName: '',
          rating: 0.0,
          category: '',
        ),
      );
      sum += item.price * value;
    });
    return sum;
  }

  // -------------------- SHOW CART DIALOG --------------------
  void _showCartDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Checkout"),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...cart.entries.map((entry) {
                final item = menuItems.firstWhere((i) => i.id == entry.key);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${item.name} x ${entry.value}"),
                      Text("\$${(item.price * entry.value).toStringAsFixed(2)}"),
                    ],
                  ),
                );
              }).toList(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => cart.clear());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Order placed successfully!")),
              );
            },
            child: const Text("Confirm Order"),
          ),
        ],
      ),
    );
  }

  // -------------------- BUILD MENU SECTION --------------------
  Widget _buildMenuSection() {
    if (menuItems.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No menu items available'),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Menu',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            final quantity = cart[item.id] ?? 0;

            return ListTile(
              leading: Image.network(
                item.imageUrl,
                width: 50,
                height: 50,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_not_supported),
              ),
              title: Text(item.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\$${item.price.toStringAsFixed(2)}"),
                  Text(item.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
              trailing: SizedBox(
                width: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (cart[item.id] != null && cart[item.id]! > 0) {
                            cart[item.id] = cart[item.id]! - 1;
                            if (cart[item.id] == 0) cart.remove(item.id);
                          }
                        });
                      },
                    ),
                    Text(quantity.toString()),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          cart[item.id] = (cart[item.id] ?? 0) + 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // -------------------- MAIN BUILD --------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurant.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: cart.isEmpty ? null : _showCartDialog,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.restaurant.imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.image_not_supported, size: 50)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Welcome to ${widget.restaurant.name}! Enjoy the best ${widget.restaurant.cuisine} food in town.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _buildMenuSection(),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: cart.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(
                          cartItems: cart.entries.map((entry) {
                            final item = menuItems.firstWhere((i) => i.id == entry.key);
                            return CartItemModel(menuItem: item, quantity: entry.value);
                          }).toList(),
                          totalPrice: totalPrice,
                          total: 0.0,
                        ),
                      ),
                    );
                  },
                  child: Text('Checkout • \$${totalPrice.toStringAsFixed(2)}'),
                ),
              ),
            ),
    );
  }
}
