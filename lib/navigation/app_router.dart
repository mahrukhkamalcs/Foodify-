import 'package:flutter/material.dart';
import '../data/models/cart/cart_item_model.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/role_selection.dart';
import '../features/auth/customer_login_screen.dart';
import '../features/auth/signup/customer_signup_screen.dart';
import '../features/auth/vendor_login_screen.dart';
import '../features/auth/signup/vendor_signup_screen.dart';
import '../features/orders/screens/order_tracking_screen.dart';
import '../features/payment/screens/order_success_screen.dart';
import 'main_navigation.dart'; // ✅ Fixed import path

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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

      case MainNavigation.routeName:
        return MaterialPageRoute(builder: (_) => const MainNavigation());

      case OrderSuccessScreen.routeName:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null) {
          return _errorRoute('Missing order data');
        }
        return MaterialPageRoute(
          builder: (_) => OrderSuccessScreen(
            orderId: args['orderId'] as String,
            restaurantName: args['restaurantName'] as String,
            totalAmount: args['totalAmount'] as double,
            estimatedDeliveryTime: args['estimatedDeliveryTime'] as String,
            cartItems: args['cartItems'] as List<CartItemModel>, // ✅ Pass cart items
          ),
        );

      case '/order-tracking':
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null) {
          return _errorRoute('Missing tracking data');
        }
        return MaterialPageRoute(
          builder: (_) => OrderTrackingScreen(
            orderId: args['orderId'] as String,
            estimatedDeliveryTime: args['estimatedDeliveryTime'] as String,
          ),
        );

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