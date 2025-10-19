import '../../data/models/cart/cart_item_model.dart';
import '../../data/models/restaurant/menu_item_model.dart';

/// Simple singleton service to manage cart state across the app
/// This is a basic implementation without state management
class CartService {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get items => List.unmodifiable(_cartItems);

  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  bool get isEmpty => _cartItems.isEmpty;

  /// Add item to cart or increase quantity if already exists
  void addItem(MenuItemModel menuItem, {String? specialInstructions}) {
    final existingIndex = _cartItems.indexWhere(
      (item) => item.menuItem.id == menuItem.id,
    );

    if (existingIndex != -1) {
      _cartItems[existingIndex].quantity++;
    } else {
      _cartItems.add(
        CartItemModel(
          menuItem: menuItem,
          quantity: 1,
          specialInstructions: specialInstructions,
        ),
      );
    }
  }

  /// Remove item from cart
  void removeItem(String menuItemId) {
    _cartItems.removeWhere((item) => item.menuItem.id == menuItemId);
  }

  /// Update item quantity
  void updateQuantity(String menuItemId, int quantity) {
    final index = _cartItems.indexWhere(
      (item) => item.menuItem.id == menuItemId,
    );

    if (index != -1) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
    }
  }

  /// Clear entire cart
  void clear() {
    _cartItems.clear();
  }

  /// Get cart item by menu item ID
  CartItemModel? getItem(String menuItemId) {
    try {
      return _cartItems.firstWhere((item) => item.menuItem.id == menuItemId);
    } catch (e) {
      return null;
    }
  }

  /// Check if item exists in cart
  bool containsItem(String menuItemId) {
    return _cartItems.any((item) => item.menuItem.id == menuItemId);
  }
}
