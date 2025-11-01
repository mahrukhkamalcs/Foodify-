import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/restaurant/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({super.key});
  static const routeName = '/add-restaurant';

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String cuisine = '';
  String imageUrl = '';
  double rating = 0.0;
  String address = '';

  Future<void> _saveRestaurant() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    final prefs = await SharedPreferences.getInstance();

    // 1️⃣ Load existing restaurants
    final String? existingJson = prefs.getString('vendor_restaurants');
    List<dynamic> existingList = [];
    if (existingJson != null) {
      existingList = json.decode(existingJson);
    }

    // 2️⃣ Create new vendor restaurant
    final newRestaurant = RestaurantModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // unique ID
      name: name,
      cuisine: cuisine,
      imageUrl: imageUrl,
      rating: rating,
      address: address,
      deliveryTime: '30–45 min',
      isFreeDelivery: true,
      distance: 1.0,
      deliveryFee: 0.0, menu: [],
    );

    // 3️⃣ Add to list
    existingList.add(newRestaurant.toJson());

    // 4️⃣ Save back to SharedPreferences
    await prefs.setString('vendor_restaurants', json.encode(existingList));

    // Optional: show success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Restaurant added successfully!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Restaurant')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Restaurant Name'),
                validator: (val) => val!.isEmpty ? 'Enter name' : null,
                onSaved: (val) => name = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cuisine'),
                onSaved: (val) => cuisine = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image URL'),
                onSaved: (val) => imageUrl = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
                onSaved: (val) => address = val!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Rating'),
                keyboardType: TextInputType.number,
                onSaved: (val) => rating = double.tryParse(val!) ?? 0.0,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRestaurant,
                child: const Text('Save Restaurant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
