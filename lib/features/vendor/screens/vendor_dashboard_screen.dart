import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../restaurant/screens/restaurant_details_screen.dart';
import '../../../data/models/restaurant/restaurant_model.dart';
import 'add_menu_item_screen.dart';
import 'view_menu_screen.dart';
import 'add_restaurant_screen.dart';

class VendorDashboardScreen extends StatefulWidget {
  static const routeName = '/vendor-dashboard';
  const VendorDashboardScreen({super.key});

  @override
  State<VendorDashboardScreen> createState() => _VendorDashboardScreenState();
}

class _VendorDashboardScreenState extends State<VendorDashboardScreen> {
  String vendorName = 'Vendor';
  String vendorEmail = '';
  List<Map<String, dynamic>> restaurants = [];

  @override
  void initState() {
    super.initState();
    _loadVendorData();
    _loadVendorRestaurants();
  }

  Future<void> _loadVendorData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      vendorName = prefs.getString('vendorName') ?? 'Vendor';
      vendorEmail = prefs.getString('vendorEmail') ?? '';
    });
  }

  Future<void> _loadVendorRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final String? vendorJson = prefs.getString('vendor_restaurants');
    if (vendorJson != null) {
      setState(() {
        restaurants = List<Map<String, dynamic>>.from(json.decode(vendorJson));
      });
    }
  }

  Future<void> _logout() async {
  final prefs = await SharedPreferences.getInstance();
  final restaurantsJson = prefs.getString('vendor_restaurants'); // save
  await prefs.clear(); // clear only session
  if (restaurantsJson != null) {
    await prefs.setString('vendor_restaurants', restaurantsJson); // restore
  }
  if (!mounted) return;
  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Dashboard'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddRestaurantScreen()),
          ).then((_) => _loadVendorRestaurants());
        },
        icon: const Icon(Icons.add_business),
        label: const Text("Add Restaurant"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor Info
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.store, color: Colors.white, size: 35),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vendorName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        vendorEmail,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const Text(
              "Menu Management",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _buildDashboardButton(
              icon: Icons.add_circle_outline,
              title: 'Add Menu Item',
              subtitle: 'Create a new food item for your restaurant',
              onTap: () {
                if (restaurants.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add a restaurant first')),
                  );
                  return;
                }

                // For demo, pick the first restaurant
                final restaurant = RestaurantModel.fromJson(restaurants[0]);

                Navigator.pushNamed(
                  context,
                  AddMenuItemScreen.routeName,
                  arguments: {'restaurant': restaurant},
                ).then((_) => _loadVendorRestaurants());
              },
            ),
            const SizedBox(height: 12),
            _buildDashboardButton(
              icon: Icons.list_alt_rounded,
              title: 'View Menu Items',
              subtitle: 'Check all items currently listed',
              onTap: () {
                if (restaurants.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add a restaurant first')),
                  );
                  return;
                }
                final restaurant = RestaurantModel.fromJson(restaurants[0]);

                Navigator.pushNamed(
                  context,
                  ViewMenuScreen.routeName,
                  arguments: {'restaurant': restaurant},
                );
              },
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1),
            const Text(
              "Your Restaurants",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            restaurants.isEmpty
                ? const Text("No restaurants added yet.", style: TextStyle(color: Colors.grey))
                : Column(
                    children: restaurants.map((r) {
                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            r['imageUrl'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                          ),
                          title: Text(r['name']),
                          subtitle: Text(
                              "${r['cuisine']} • ${r['deliveryTime']} • ⭐ ${r['rating']}"),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.teal.shade100,
          child: Icon(icon, color: Colors.teal, size: 28),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}
