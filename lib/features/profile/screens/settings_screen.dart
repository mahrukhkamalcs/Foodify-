import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../widgets/profile_menu_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String userName = 'Customer';
  String userEmail = '';
  bool notificationsEnabled = true;
  bool isDarkMode = false;
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName') ?? 'Customer';
      userEmail = prefs.getString('userEmail') ?? '';
      notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      selectedLanguage = prefs.getString('language') ?? 'English';
    });
  }

  Future<void> _saveUserName(String newName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', newName);
    setState(() => userName = newName);
  }

  Future<void> _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    setState(() => selectedLanguage = language);
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    setState(() => isDarkMode = value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value ? 'Dark Mode Enabled' : 'Dark Mode Disabled'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _changeName() {
    final controller = TextEditingController(text: userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Display Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _saveUserName(controller.text.trim());
              Navigator.of(ctx).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Old Password'),
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'New Password'),
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              // Implement password change logic here
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password changed successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _toggleNotifications(bool value) async {
    setState(() => notificationsEnabled = value);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', value);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(notificationsEnabled ? 'Notifications Enabled' : 'Notifications Disabled'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/customer-login', (_) => false);
  }

  void _changeLanguage() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['English', 'Spanish', 'French', 'German']
              .map(
                (lang) => RadioListTile<String>(
                  value: lang,
                  groupValue: selectedLanguage,
                  title: Text(lang),
                  onChanged: (value) {
                    _saveLanguage(value!);
                    Navigator.of(ctx).pop();
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _contactSupport() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Contact Support'),
        content: const Text('Email: support@example.com\nPhone: +123456789'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.white, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingMedium),
            // Display Name Section
            ListTile(
              leading: const Icon(Icons.person),
              title: Text('Display Name', style: AppTextStyles.h4),
              subtitle: Text(userName),
              trailing: IconButton(icon: const Icon(Icons.edit), onPressed: _changeName),
            ),
            const Divider(),
            // Settings menu
            Container(
              margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(icon: Icons.lock_outline, title: 'Change Password', onTap: _changePassword),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    trailing: Switch(
                      value: notificationsEnabled,
                      onChanged: _toggleNotifications,
                      activeColor: AppColors.primary,
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    subtitle: Text(selectedLanguage),
                    onTap: _changeLanguage,
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.brightness_6),
                    title: const Text('Dark Mode'),
                    trailing: Switch(
                      value: isDarkMode,
                      onChanged: _toggleDarkMode,
                      activeColor: AppColors.primary,
                    ),
                  ),
                  const Divider(height: 1),
                  ProfileMenuItem(icon: Icons.support_agent, title: 'Contact Support', onTap: _contactSupport),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('App Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMedium),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _logout,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusMedium)),
                    padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium),
                  ),
                  child: Text('Logout', style: AppTextStyles.button.copyWith(color: Colors.red)),
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
