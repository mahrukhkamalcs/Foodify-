class MenuItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final String restaurantName;
  final double rating;
  final double price;
  final String? description;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.restaurantName,
    required this.rating,
    required this.price,
    this.description,
    this.category = 'Popular',
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      restaurantName: json['restaurantName'],
      rating: json['rating'].toDouble(),
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category'] ?? 'Popular',
    );
  }
}
