import 'package:flutter_application_1/data/models/restaurant/menu_item_model.dart';

class RestaurantModel {
  final String id;
  final String name;
  final String cuisine;
  final String imageUrl;
  final double rating;
  final String address;
  final String deliveryTime;
  final bool isFreeDelivery;
  final double distance;
  final double deliveryFee;
  final List<MenuItemModel> menu; // new

  RestaurantModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.deliveryTime,
    required this.isFreeDelivery,
    required this.distance,
    required this.deliveryFee,
    required this.menu,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'].toString(),
      name: json['name'],
      cuisine: json['cuisine'],
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      address: json['address'],
      deliveryTime: json['deliveryTime'],
      isFreeDelivery: json['isFreeDelivery'] ?? false,
      distance: (json['distance'] != null) ? (json['distance'] as num).toDouble() : 0.0,
      deliveryFee: (json['deliveryFee'] != null) ? (json['deliveryFee'] as num).toDouble() : 0.0,
      menu: (json['menu'] as List<dynamic>?)
              ?.map((item) => MenuItemModel.fromJson(item))
              .toList() ??
          [], 
    );
  }
}
