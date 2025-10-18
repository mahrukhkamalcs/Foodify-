import 'package:flutter/material.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/auth/role_selection.dart';
import '../features/auth/customer_login_screen.dart';
import '../features/auth/signup/customer_signup_screen.dart';
import '../features/auth/vendor_login_screen.dart';
import '../features/auth/signup/vendor_signup_screen.dart';
import 'main_navigation.dart';

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

      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Page not found')),
              ),
        );
    }
  }
}
