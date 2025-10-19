import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/restaurant/restaurant_model.dart';
import '../../../data/models/restaurant/menu_item_model.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../cart/screens/cart_screen.dart';
import '../widgets/restaurant_banner.dart';
import '../widgets/restaurant_info.dart';
import '../widgets/menu_category_tabs.dart';
import '../widgets/menu_item_tile.dart';
import '../widgets/view_cart_bar.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final RestaurantModel restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  State<RestaurantDetailsScreen> createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  String _selectedCategory = 'Popular';
  bool _isFavorite = false;

  // Cart items list
  final List<CartItemModel> _cartItems = [];

  final List<String> _categories = [
    'Popular',
    'Appetizers',
    'Main Courses',
    'Desserts',
    'Drinks',
  ];

  final List<MenuItemModel> _menuItems = [
    MenuItemModel(
      id: '1',
      name: 'Fiery Wings',
      imageUrl:
          'https://images.unsplash.com/photo-1608039829572-78524f79c4c7?w=200',
      restaurantName: 'The Spice Merchant',
      rating: 4.5,
      price: 12.99,
      description: 'Spicy chicken wings with a tangy dipping sauce',
      category: 'Popular',
    ),
    MenuItemModel(
      id: '2',
      name: 'Spring Rolls',
      imageUrl:
          'https://images.unsplash.com/photo-1625398407796-82650a8c135f?w=200',
      restaurantName: 'The Spice Merchant',
      rating: 4.3,
      price: 8.99,
      description: 'Crispy spring rolls filled with vegetables and shrimp',
      category: 'Popular',
    ),
    MenuItemModel(
      id: '3',
      name: 'Pork Dumplings',
      imageUrl:
          'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=200',
      restaurantName: 'The Spice Merchant',
      rating: 4.7,
      price: 10.99,
      description: 'Savory dumplings with a pork and chive filling',
      category: 'Popular',
    ),
  ];

  List<MenuItemModel> get _filteredMenuItems {
    return _menuItems
        .where((item) => item.category == _selectedCategory)
        .toList();
  }

  int get _cartItemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  void _addToCart(MenuItemModel menuItem) {
    setState(() {
      // Check if item already exists in cart
      final existingIndex = _cartItems.indexWhere(
        (cartItem) => cartItem.menuItem.id == menuItem.id,
      );

      if (existingIndex != -1) {
        // Item exists, increase quantity
        _cartItems[existingIndex].quantity++;
      } else {
        // New item, add to cart
        _cartItems.add(CartItemModel(menuItem: menuItem, quantity: 1));
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${menuItem.name} added to cart'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => CartScreen(
              initialCartItems: _cartItems,
              onCartUpdated: (updatedItems) {
                setState(() {
                  _cartItems.clear();
                  _cartItems.addAll(updatedItems);
                });
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Column(
          children: [
            // Banner
            RestaurantBanner(
              imageUrl: widget.restaurant.imageUrl,
              isFavorite: _isFavorite,
              onBackPressed: () => Navigator.pop(context),
              onFavoritePressed: () {
                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),

            // Restaurant Info
            RestaurantInfo(restaurant: widget.restaurant),

            const SizedBox(height: AppDimensions.paddingSmall),

            // Category Tabs
            MenuCategoryTabs(
              categories: _categories,
              selectedCategory: _selectedCategory,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),

            // Menu Items List
            Expanded(
              child:
                  _filteredMenuItems.isEmpty
                      ? Center(
                        child: Text(
                          'No items in this category',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 16,
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.only(
                          top: AppDimensions.paddingMedium,
                          bottom: AppDimensions.paddingXLarge,
                        ),
                        itemCount: _filteredMenuItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredMenuItems[index];
                          return MenuItemTile(
                            item: item,
                            onAddToCart: () => _addToCart(item),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),

      // Only show ViewCartBar when cart has items
      bottomNavigationBar:
          _cartItemCount > 0
              ? ViewCartBar(
                itemCount: _cartItemCount,
                onPressed: _navigateToCart,
              )
              : null,
    );
  }
}
