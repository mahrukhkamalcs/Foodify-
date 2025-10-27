import '../restaurant/menu_item_model.dart';

class CartItemModel {
  final MenuItemModel menuItem;
  int quantity;
  final String? specialInstructions;

  CartItemModel({
    required this.menuItem,
    this.quantity = 1,
    this.specialInstructions,
  });

  double get totalPrice => menuItem.price * quantity;

  CartItemModel copyWith({
    MenuItemModel? menuItem,
    int? quantity,
    String? specialInstructions,
  }) {
    return CartItemModel(
      menuItem: menuItem ?? this.menuItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      menuItem: MenuItemModel.fromJson(json['menuItem']),
      quantity: json['quantity'] as int? ?? 1,
      specialInstructions: json['specialInstructions'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'menuItem': menuItem.toJson(),
        'quantity': quantity,
        'specialInstructions': specialInstructions,
      };
}
