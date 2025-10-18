import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/features/auth/customer_login_screen.dart';
import 'package:flutter_application_1/features/auth/signup/customer_signup_screen.dart';
import 'package:flutter_application_1/features/auth/signup/vendor_signup_screen.dart';
import 'package:flutter_application_1/features/auth/vendor_login_screen.dart';
import 'core/theme/app_theme.dart';
import 'navigation/main_navigation.dart';
import 'features/onboarding/onboarding_screen.dart';
import '../features/auth/role_selection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const FoodifyApp());
 // runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigation(), // Changed from HomeScreen to MainNavigation
    );
  }
}


class FoodifyApp extends StatelessWidget {
  const FoodifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.orange,
        brightness: Brightness.light,
      ),
      initialRoute: OnboardingScreen.routeName,
      routes: {
        OnboardingScreen.routeName: (ctx) => const OnboardingScreen(),
        RoleSelectionScreen.routeName: (ctx) => const RoleSelectionScreen(),
        CustomerLoginScreen.routeName: (ctx) => const CustomerLoginScreen(),
        CustomerSignupScreen.routeName: (ctx) => const CustomerSignupScreen(),
        VendorLoginScreen.routeName: (ctx) => const VendorLoginScreen(),
        VendorSignupScreen.routeName: (ctx) => const VendorSignupScreen()
      },
    );
  }
}