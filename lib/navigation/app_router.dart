import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/restaurant/restaurant_model.dart';
import 'package:flutter_application_1/features/feedback/screens/feedback_form.dart';
import 'package:flutter_application_1/features/restaurant/screens/restaurant_details_screen.dart';
import '../data/models/cart/cart_item_model.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/role_selection.dart';
import '../features/auth/customer_login_screen.dart';
import '../features/auth/signup/customer_signup_screen.dart';
import '../features/auth/vendor_login_screen.dart';
import '../features/auth/signup/vendor_signup_screen.dart';
import '../features/onboarding/splash_screen.dart';
import '../features/orders/screens/order_tracking_screen.dart';
import '../features/payment/screens/order_success_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../features/profile/screens/my_orders_screen.dart';
import '../features/profile/screens/saved_addresses_screen.dart';
import '../features/profile/screens/payment_methods_screen.dart';
import '../features/profile/screens/settings_screen.dart';
import '../features/vendor/screens/vendor_dashboard_screen.dart';
import '../features/vendor/screens/add_menu_item_screen.dart';
import '../features/vendor/screens/view_menu_screen.dart';
import 'main_navigation.dart'; // ✅ Fixed import path

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // -------------------------
      // 🔹 Onboarding & Auth Flow
      // -------------------------
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case OnboardingScreen.routeName:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case RoleSelectionScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case CustomerLoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const CustomerLoginScreen());

      case CustomerSignupScreen.routeName:
        return MaterialPageRoute(builder: (_) => const CustomerSignupScreen());

      case VendorLoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => const VendorLoginScreen());

      case VendorSignupScreen.routeName:
        return MaterialPageRoute(builder: (_) => const VendorSignupScreen());

      // -------------------------
      // 🔹 Main App Navigation
      // -------------------------
      case MainNavigation.routeName:
        return MaterialPageRoute(builder: (_) => const MainNavigation());

      // -------------------------
      // 🔹 Customer Profile Section
      // -------------------------
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case '/my-orders':
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());

      case '/saved-addresses':
        return MaterialPageRoute(builder: (_) => const SavedAddressesScreen());

      case '/payment-methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());

      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      // -------------------------
      // 🔹 Vendor Section
      // -------------------------
      case VendorDashboardScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => const VendorDashboardScreen());

      case AddMenuItemScreen.routeName:
  final args = settings.arguments as Map<String, dynamic>?;
  if (args == null || args['restaurant'] == null) {
    return _errorRoute('Restaurant data is required for adding menu item');
  }
  final RestaurantModel restaurant = args['restaurant'] as RestaurantModel;
  return MaterialPageRoute(
    builder: (_) => AddMenuItemScreen(restaurant: restaurant),
  );

      case ViewMenuScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ViewMenuScreen());

      // -------------------------
      // 🔹 Order & Payment
      // -------------------------
      case OrderSuccessScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null) return _errorRoute('Missing order data');
        return MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(
            orderId: args['orderId'] as String,
            restaurantName: args['restaurantName'] as String,
            totalAmount: args['totalAmount'] as double,
            estimatedDeliveryTime: args['estimatedDeliveryTime'] as String,
            cartItems: args['cartItems'] as List<CartItemModel>,
          ),
        );

      case '/order-tracking':
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null) return _errorRoute('Missing tracking data');
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            orderId: args['orderId'] as String,
            estimatedDeliveryTime: args['estimatedDeliveryTime'] as String,
          ),
        );

      // -------------------------
      // 🔹 Feedback
      // -------------------------
      case '/feedback':
        return MaterialPageRoute(builder: (_) => FeedbackForm());

      // -------------------------
      // 🔹 Default Error Route
      // -------------------------
      default:
        return _errorRoute('404 - Page not found');
    }
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text(message)),
      ),
    );
  }
}
