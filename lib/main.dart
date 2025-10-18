import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';
import 'features/onboarding/onboarding_screen.dart';
=======
import 'orderstatus.dart';
import 'profile.dart';
>>>>>>> main

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const FoodifyApp());
}

class FoodifyApp extends StatelessWidget {
  const FoodifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'Foodify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
     
      onGenerateRoute: AppRouter.generateRoute, //  Centralized navigation
       initialRoute: OnboardingScreen.routeName,
=======
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const OrderStatusScreen(),
>>>>>>> main
    );
  }
}
