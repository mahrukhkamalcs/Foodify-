import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/features/auth/customer_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = 'Customer';
  String userEmail = '';
  int userId = -1;

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  Future<void> _loadUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId') ?? -1;
      userEmail = prefs.getString('userEmail') ?? '';
      userName = prefs.getString('userName') ?? 'Customer';
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, CustomerLoginScreen.routeName);
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
        title: Text('Profile', style: AppTextStyles.h3),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingMedium),

            // Profile Header
            ProfileHeader(
              name: userName,
              email: userEmail,
              imageUrl: '',
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Menu Items
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    icon: Icons.receipt_long,
                    title: 'My Orders',
                    onTap: () {
                      Navigator.pushNamed(context, '/my-orders');
                    },
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.location_on,
                    title: 'Saved Addresses',
                    onTap: () {
                      Navigator.pushNamed(context, '/saved-addresses');
                    },
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.payment,
                    title: 'Payment Methods',
                    onTap: () {
                      Navigator.pushNamed(context, '/payment-methods');
                    },
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () async {
                      final updatedName = await Navigator.pushNamed(context, '/settings');
                      if (updatedName != null && updatedName is String) {
                        setState(() {
                          userName = updatedName;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.paddingLarge),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _logout,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingMedium,
                    ),
                  ),
                  child: Text(
                    'Logout',
                    style: AppTextStyles.button.copyWith(color: Colors.red),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingXLarge),
          ],
        ),
      ),
    );
  }
}
