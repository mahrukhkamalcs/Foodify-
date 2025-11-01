import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/restaurant/menu_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMenuScreen extends StatefulWidget {
  static const routeName = '/view-menu';
  const ViewMenuScreen({super.key});

  @override
  State<ViewMenuScreen> createState() => _ViewMenuScreenState();
}

class _ViewMenuScreenState extends State<ViewMenuScreen> {
  List<MenuItemModel> _menuItems = [];

  @override
  void initState() {
    super.initState();
    _loadMenuItems();
  }

  Future<void> _loadMenuItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? vendorJson = prefs.getString('vendor_restaurants');
    if (vendorJson != null) {
      final List<Map<String, dynamic>> restaurants =
          List<Map<String, dynamic>>.from(json.decode(vendorJson));
      List<MenuItemModel> allMenu = [];
      for (var r in restaurants) {
        final menuList = (r['menu'] as List<dynamic>)
            .map((m) => MenuItemModel.fromJson(m))
            .toList();
        allMenu.addAll(menuList);
      }
      setState(() => _menuItems = allMenu);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Menu Items')),
      body: _menuItems.isEmpty
          ? const Center(child: Text('No menu items yet'))
          : ListView.builder(
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return ListTile(
                  leading: Image.network(item.imageUrl, width: 50, height: 50),
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                );
              },
            ),
    );
  }
}
