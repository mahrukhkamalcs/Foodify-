import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/restaurant/menu_item_model.dart';
import 'package:flutter_application_1/data/models/restaurant/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddMenuItemScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const AddMenuItemScreen({super.key, required this.restaurant});
  static const routeName = '/add-menu-item';

  @override
  State<AddMenuItemScreen> createState() => _AddMenuItemScreenState();
}

class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String imageUrl = '';
  double price = 0.0;
  double rating = 0.0;
  String category = '';
  String description = '';

  Future<void> _saveMenuItem() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final prefs = await SharedPreferences.getInstance();

    // Load existing vendor restaurants
    final String? existingJson = prefs.getString('vendor_restaurants');
    List<dynamic> existingList = [];
    if (existingJson != null) {
      existingList = json.decode(existingJson);
    }

    // Find the restaurant to update
    int index = existingList.indexWhere(
        (r) => r['id'].toString() == widget.restaurant.id.toString());

    if (index == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Restaurant not found!')),
      );
      return;
    }

    // Create new menu item
    final newItem = MenuItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toInt(),
      name: name,
      imageUrl: imageUrl,
      price: price,
      rating: rating,
      category: category,
      description: description,
      restaurantName: widget.restaurant.name,
    );

    // Add to restaurant's menu
    List<dynamic> menuList = existingList[index]['menu'] ?? [];
    menuList.add(newItem.toJson());
    existingList[index]['menu'] = menuList;

    // Save back to SharedPreferences
    await prefs.setString('vendor_restaurants', json.encode(existingList));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Menu item added successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Menu Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Dish Name'),
                  validator: (val) => val!.isEmpty ? 'Enter name' : null,
                  onSaved: (val) => name = val!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  onSaved: (val) => imageUrl = val!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => price = double.tryParse(val!) ?? 0.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Rating'),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => rating = double.tryParse(val!) ?? 0.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Category'),
                  onSaved: (val) => category = val!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  onSaved: (val) => description = val ?? '',
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveMenuItem,
                  child: const Text('Save Menu Item'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
