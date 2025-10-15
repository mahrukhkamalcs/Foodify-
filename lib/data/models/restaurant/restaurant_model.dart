class RestaurantModel {
  final String id;
  final String name;
  final String imageUrl;
  final double rating;
  final String deliveryTime;
  final String cuisineType;
  final bool isFreeDelivery;
  final double distance;
  final double deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.deliveryTime,
    required this.cuisineType,
    this.isFreeDelivery = false,
    required this.distance,
    this.deliveryFee = 0.0,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      rating: json['rating'].toDouble(),
      deliveryTime: json['deliveryTime'],
      cuisineType: json['cuisineType'],
      isFreeDelivery: json['isFreeDelivery'] ?? false,
      distance: json['distance'].toDouble(),
      deliveryFee: json['deliveryFee']?.toDouble() ?? 0.0,
    );
  }
}
