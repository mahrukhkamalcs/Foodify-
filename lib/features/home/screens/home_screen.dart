import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/features/feedback/screens/feedback_form.dart';
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

  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'Pizza';

  // Categories (static)
  final List<CategoryModel> _categories = [
    CategoryModel(id: '1', name: 'Pizza', icon: '🍕'),
    CategoryModel(id: '2', name: 'Burgers', icon: '🍔'),
    CategoryModel(id: '3', name: 'Desserts', icon: '🍰'),
    CategoryModel(id: '4', name: 'Sushi', icon: '🍣'),
    CategoryModel(id: '5', name: 'Drinks', icon: '🥤'),
  ];

  // Restaurants (loaded dynamically)
  List<RestaurantModel> _restaurants = [];

  // Trending dishes (all menu items)
  List<MenuItemModel> get allMenuItems => _restaurants.expand((r) => r.menu).toList();

  // Load restaurants from JSON
  Future<List<RestaurantModel>> _loadRestaurants() async {
    try {
      final String response = await rootBundle.loadString('assets/data/restaurants.json');
      final data = json.decode(response);
      
      // Handle JSON root being either list or object with "restaurants" key
      
      List<dynamic> restaurantList;
      if (data is List) {
        restaurantList = data;
      } else if (data is Map<String, dynamic> && data['restaurants'] is List) {
        restaurantList = data['restaurants'];
      } else {
        restaurantList = [];
      }

      final restaurants = restaurantList
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList();

      print('✅ Parsed ${restaurants.length} restaurants');
      return restaurants;
    } catch (e) {
      print('❌ Error loading restaurants: $e');
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    _loadRestaurants().then((value) {
      setState(() {
        _restaurants = value;
      });
    });
  }

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
                        onTap: () {},
                        onFilterTap: () {},
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),

                      // Promotional Banners
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            DailyDealsBanner(
                              title: 'Daily Deals',
                              subtitle: 'Get 50% OFF on your first order!',
                              onOrderNow: () {},
                            ),
                            DailyDealsBanner(
                              title: 'Special Offer',
                              subtitle: 'Free delivery on all orders today!',
                              onOrderNow: () {},
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

                      // Category Section
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

                      // Dynamic Restaurant List
                      _restaurants.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(40),
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            )
                          : Column(
                              children: _restaurants.map(
                                (restaurant) => RestaurantCard(
                                  restaurant: restaurant,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => RestaurantDetailsScreen(
                                          restaurant: restaurant,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ).toList(),
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

      // Floating Feedback Button
      floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    Navigator.pushNamed(context, FeedbackForm.routeName);
  },
  backgroundColor: AppColors.primary,
  icon: const Icon(Icons.feedback),
  label: const Text(
    'Feedback',
    style: TextStyle(fontWeight: FontWeight.w600),
  ),
),
    );
  }

  // Header
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
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
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
        itemCount: allMenuItems.length,
        itemBuilder: (context, index) {
          final dish = allMenuItems[index];
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
                          borderRadius:
                              BorderRadius.circular(AppDimensions.radiusSmall),
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
