import 'dart:convert';
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
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<CategoryModel> _categories = [
    CategoryModel(id: '0', name: 'All', icon: '🍽️'),
    CategoryModel(id: '1', name: 'Pizza', icon: '🍕'),
    CategoryModel(id: '2', name: 'Burgers', icon: '🍔'),
    CategoryModel(id: '3', name: 'Desserts', icon: '🍰'),
    CategoryModel(id: '4', name: 'Sushi', icon: '🍣'),
    CategoryModel(id: '5', name: 'Drinks', icon: '🥤'),
  ];

  List<RestaurantModel> _restaurants = [];

  List<MenuItemModel> get allMenuItems =>
      _restaurants.expand((r) => r.menu).toList();

  @override
  void initState() {
    super.initState();
    _loadRestaurants();

    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
      });
    });
  }

  Future<void> _loadRestaurants() async {
    List<RestaurantModel> restaurants = [];

    // Load static restaurants from JSON
    try {
      final response =
          await rootBundle.loadString('assets/data/restaurants.json');
      final data = json.decode(response);
      List<dynamic> restaurantList = data['restaurants'];
      restaurants = restaurantList
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    // Load vendor-added restaurants from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? vendorJson = prefs.getString('vendor_restaurants');
    if (vendorJson != null) {
      final vendorList = List<Map<String, dynamic>>.from(json.decode(vendorJson));
      restaurants.addAll(vendorList.map((r) {
        return RestaurantModel.fromJson(r);
      }));
    }

    setState(() => _restaurants = restaurants);
  }

  @override
  Widget build(BuildContext context) {
    // Filter restaurants by category & search query
    List<RestaurantModel> filteredRestaurants = _restaurants.where((r) {
      final matchesCategory = _selectedCategory == 'All' ||
          r.menu.any((m) => m.category == _selectedCategory);
      final matchesSearch = _searchQuery.isEmpty ||
          r.name.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    HomeSearchBar(
                      onTap: () {},
                      onFilterTap: () {},
                      controller: _searchController,
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          DailyDealsBanner(
                              title: 'Daily Deals',
                              subtitle: 'Get 50% OFF!',
                              onOrderNow: () {}),
                          DailyDealsBanner(
                              title: 'Special Offer',
                              subtitle: 'Free delivery today!',
                              onOrderNow: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    CategorySection(
                      categories: _categories,
                      selectedCategory: _selectedCategory,
                      onCategorySelected: (category) {
                        setState(() => _selectedCategory = category);
                      },
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    _buildSectionHeader('Restaurants'),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    filteredRestaurants.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(40),
                              child: CircularProgressIndicator(
                                  color: AppColors.primary),
                            ),
                          )
                        : Column(
                            children: filteredRestaurants.map((restaurant) {
                              return RestaurantCard(
                                restaurant: restaurant,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RestaurantDetailsScreen(
                                          restaurant: restaurant),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    // Navigate to feedback form
    Navigator.pushNamed(context, '/feedback');
  },
  icon: const Icon(Icons.feedback),
  label: const Text('Feedback'),
  backgroundColor: AppColors.primary, // Optional: match your theme
),
floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

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
            child: const Icon(Icons.person,
                color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Delivery'),
                Text('242 Oak Street'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium),
      child: Text(title, style: AppTextStyles.h4),
    );
  }
}
