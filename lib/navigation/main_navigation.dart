import 'package:flutter/material.dart';
import '../features/home/screens/home_screen.dart';
import '../features/search/screens/search_screen.dart';
import '../features/orders/screens/orders_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import 'bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  /// Route name for navigation
  static const String routeName = '/main';

  /// Optionally start from a specific bottom tab index
  final int initialIndex;

  const MainNavigation({super.key, this.initialIndex = 0});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  static const int _pageCount = 4; // Total number of bottom navigation pages

  late int _currentIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Clamp ensures the initial index is within a valid range (0 to 3)
    _currentIndex = widget.initialIndex.clamp(0, _pageCount - 1);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Called when user swipes (if enabled) or page changes programmatically
  void _onPageChanged(int index) {
    if (index >= 0 && index < _pageCount) {
      setState(() => _currentIndex = index);
    }
  }

  /// Called when a bottom nav item is tapped
  void _onNavItemTapped(int index) {
    if (index >= 0 && index < _pageCount) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(), // Disable manual swipe
        children: const [
          HomeScreen(), // 🏠 Home tab
          SearchScreen(), // 🔍 Search tab
          OrdersScreen(), // 📦 Orders tab
          ProfileScreen(), // 👤 Profile tab
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
      ),
    );
  }
}
