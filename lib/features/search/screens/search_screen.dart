import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/restaurant/restaurant_model.dart';
import '../../../data/models/restaurant/menu_item_model.dart';
import '../../../features/restaurant/screens/restaurant_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<RestaurantModel> _restaurants = [];
  List<RestaurantModel> _filteredRestaurants = [];

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _searchController.addListener(_filterRestaurants);
  }

  Future<void> _loadRestaurants() async {
    List<RestaurantModel> restaurants = [];

    // 1️⃣ Load static restaurants from JSON
    try {
      final response =
          await rootBundle.loadString('assets/data/restaurants.json');
      final data = json.decode(response);
      List<dynamic> restaurantList = data['restaurants'];
      restaurants = restaurantList
          .map((e) => RestaurantModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {}

    // 2️⃣ Load vendor-added restaurants from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final String? vendorJson = prefs.getString('vendor_restaurants');
    if (vendorJson != null) {
      final vendorList = List<Map<String, dynamic>>.from(json.decode(vendorJson));
      restaurants.addAll(vendorList.map((r) => RestaurantModel.fromJson(r)));
    }

    setState(() {
      _restaurants = restaurants;
      _filteredRestaurants = restaurants;
    });
  }

  void _filterRestaurants() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRestaurants = _restaurants.where((restaurant) {
        final matchesRestaurant = restaurant.name.toLowerCase().contains(query);
        final matchesMenu = restaurant.menu.any(
            (menuItem) => menuItem.name.toLowerCase().contains(query));
        return matchesRestaurant || matchesMenu;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search for restaurants or dishes',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textHint,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
                vertical: 12,
              ),
            ),
          ),
        ),
      ),
      body: _filteredRestaurants.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 80, color: AppColors.textHint),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Text('No Results', style: AppTextStyles.h3),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  Text(
                    'No restaurants or dishes match your search.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              itemCount: _filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = _filteredRestaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(restaurant.name),
                    subtitle: Text(
                      restaurant.menu
                          .map((e) => e.name)
                          .take(3)
                          .join(', '), // show first 3 menu items
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RestaurantDetailsScreen(restaurant: restaurant),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
