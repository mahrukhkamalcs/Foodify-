import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/splash_screen.dart';
import 'navigation/app_router.dart';
import 'features/onboarding/onboarding_screen.dart';

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
      title: 'Foodify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
  
      onGenerateRoute: AppRouter.generateRoute, //  Centralized navigation
    initialRoute: SplashScreen.routeName,
    );
  }
}
