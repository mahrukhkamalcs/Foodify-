import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/restaurant/category_model.dart';
import '../../../data/models/restaurant/restaurant_model.dart';
import '../../../data/models/restaurant/menu_item_model.dart';
import '../../restaurant/screens/restaurant_details_screen.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/daily_deals_banner.dart';
import '../widgets/category_section.dart';
import '../widgets/restaurant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Pizza';

  // Mock Data
  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Pizza', icon: '🍕'),
    CategoryModel(id: '2', name: 'Burgers', icon: '🍔'),
    CategoryModel(id: '3', name: 'Desserts', icon: '🍰'),
    CategoryModel(id: '4', name: 'Sushi', icon: '🍣'),
    CategoryModel(id: '5', name: 'Drinks', icon: '🥤'),
  ];

  final List<RestaurantModel> _restaurants = [
    RestaurantModel(
      id: '1',
      name: 'The Italian Place',
      imageUrl:
          'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400',
      rating: 4.5,
      deliveryTime: '20-30min',
      cuisineType: 'Italian',
      isFreeDelivery: true,
      distance: 2.5,
      deliveryFee: 0.0,
    ),
    RestaurantModel(
      id: '2',
      name: 'Burger Haven',
      imageUrl:
          'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400',
      rating: 4.7,
      deliveryTime: '25-35min',
      cuisineType: 'American',
      isFreeDelivery: false,
      distance: 3.2,
      deliveryFee: 2.50,
    ),
    RestaurantModel(
      id: '3',
      name: 'The Spice Merchant',
      imageUrl:
          'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=400',
      rating: 4.5,
      deliveryTime: '30-45min',
      cuisineType: 'Asian Fusion',
      isFreeDelivery: false,
      distance: 2.5,
      deliveryFee: 1.50,
    ),
  ];

  final List<MenuItemModel> _trendingDishes = [
    MenuItemModel(
      id: '1',
      name: 'Spicy Chicken Wings',
      imageUrl:
          'https://images.unsplash.com/photo-1608039829572-78524f79c4c7?w=200',
      restaurantName: 'From the Wing Spot',
      rating: 4.8,
      price: 12.99,
    ),
    MenuItemModel(
      id: '2',
      name: 'Veg Supreme Pizza',
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200',
      restaurantName: 'From Pizza Palace',
      rating: 4.6,
      price: 15.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HomeSearchBar(
                        onTap: () {
                          // Search will be handled by bottom nav
                        },
                        onFilterTap: () {
                          // Show filter bottom sheet
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DailyDealsBanner(
                              title: 'Daily Deals',
                              subtitle: 'Get 50% OFF on your first order!',
                              onOrderNow: () {
                                // Handle order now
                              },
                            ),
                            DailyDealsBanner(
                              title: 'Special Offer',
                              subtitle: 'Free delivery on all orders today!',
                              onOrderNow: () {
                                // Handle order now
                              },
                            ),
                            DailyDealsBanner(
                              title: 'Combo Deals',
                              subtitle: 'Buy 1 Get 1 Free on selected items!',
                              onOrderNow: () {},
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: AppDimensions.paddingMedium),
                      CategorySection(
                        categories: _categories,
                        selectedCategory: _selectedCategory,
                        onCategorySelected: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      _buildSectionHeader('Featured Restaurants'),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      ..._restaurants.map(
                        (restaurant) => RestaurantCard(
                          restaurant: restaurant,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => RestaurantDetailsScreen(
                                      restaurant: restaurant,
                                    ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),
                      _buildSectionHeader('Trending Dishes'),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      _buildTrendingDishes(),
                      const SizedBox(height: AppDimensions.paddingXLarge),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      color: Colors.white,
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: const Icon(Icons.person, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '242 Oak Street',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingSmall),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusSmall,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textPrimary,
                  size: 24,
                ),
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      child: Text(title, style: AppTextStyles.h4),
    );
  }

  Widget _buildTrendingDishes() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
        itemCount: _trendingDishes.length,
        itemBuilder: (context, index) {
          final dish = _trendingDishes[index];
          return _buildTrendingDishCard(dish);
        },
      ),
    );
  }

  Widget _buildTrendingDishCard(MenuItemModel dish) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    dish.name,
                    style: AppTextStyles.h4.copyWith(fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dish.restaurantName,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dish.rating.toString(),
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusSmall,
                          ),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                        ),
                      ),
                      child: Text(
                        'Order Now',
                        style: AppTextStyles.buttonSmall.copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.grey[200],
                child: Image.network(
                  dish.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
