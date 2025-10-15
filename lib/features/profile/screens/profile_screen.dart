import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            const ProfileHeader(
              name: 'John Doe',
              email: 'john.doe@example.com',
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
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.location_on,
                    title: 'Saved Addresses',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.payment,
                    title: 'Payment Methods',
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {},
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
                  onPressed: () {
                    // Handle logout
                  },
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
