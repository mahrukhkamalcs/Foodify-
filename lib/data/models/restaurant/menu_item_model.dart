class MenuItemModel {
  final int id;
  final String name;
  final String imageUrl;
  final String restaurantName;
  final double rating;
  final double price;
  final String description;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.restaurantName,
    required this.rating,
    required this.price,
    required this.description,
    required this.category,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
  //   double parseDouble(dynamic value) {
  //   if (value is num) return value.toDouble();
  //   if (value is String) return double.tryParse(value) ?? 0.0;
  //   return 0.0;
  // }
    return MenuItemModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] ?? 'No Name',
      imageUrl: json['imageUrl'] ?? '',
      restaurantName: json['restaurantName'] ?? 'Unknown Restaurant',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? 'No description available',
      category: json['category'] ?? 'Popular',
    );
  }
}
