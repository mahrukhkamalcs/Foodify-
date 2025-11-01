import 'dart:convert';
import 'package:flutter_application_1/data/models/restaurant/restaurant_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


class VendorService {
  static const String _vendorRestaurantsKey = 'vendor_restaurants';

  static Future<void> saveRestaurant(RestaurantModel restaurant) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> existingData = prefs.getStringList(_vendorRestaurantsKey) ?? [];
    existingData.add(jsonEncode(restaurant.toJson()));
    await prefs.setStringList(_vendorRestaurantsKey, existingData);
  }

  static Future<List<RestaurantModel>> fetchVendorRestaurants() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> storedData = prefs.getStringList(_vendorRestaurantsKey) ?? [];
    return storedData
        .map((jsonString) => RestaurantModel.fromJson(jsonDecode(jsonString)))
        .toList();
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_vendorRestaurantsKey);
  }
}
