import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class VendorSignupScreen extends StatefulWidget {
  static const routeName = '/vendor-signup';
  const VendorSignupScreen({super.key});

  @override
  State<VendorSignupScreen> createState() => _VendorSignupScreenState();
}

class _VendorSignupScreenState extends State<VendorSignupScreen> {
  final TextEditingController restaurantNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<Map<String, dynamic>> vendors = [];

  @override
  void initState() {
    super.initState();
    _loadVendors();
  }

  Future<void> _loadVendors() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/vendor_signup.json');
      final data = json.decode(response);
      final List list = data['vendors'];
      setState(() {
        vendors = List<Map<String, dynamic>>.from(list);
      });
    } catch (e) {
      debugPrint('Error loading vendor JSON: $e');
    }
  }

  Future<void> _signup() async {
    if (restaurantNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    // Save vendor info locally
    final prefs = await SharedPreferences.getInstance();
    List<String> storedVendors = prefs.getStringList('vendor_accounts') ?? [];

    final newVendor = json.encode({
      'restaurantName': restaurantNameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    storedVendors.add(newVendor);
    await prefs.setStringList('vendor_accounts', storedVendors);
    await prefs.setString('userRole', 'vendor');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Vendor account created successfully!")),
    );

    Navigator.pushReplacementNamed(context, '/vendor-login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Vendor Sign Up", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 30),
              CustomTextField(
                label: "Restaurant Name",
                controller: restaurantNameController,
                icon: Icons.store_outlined,
              ),
              CustomTextField(
                label: "Email",
                controller: emailController,
                icon: Icons.email_outlined,
              ),
              CustomTextField(
                label: "Password",
                controller: passwordController,
                icon: Icons.lock_outline,
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // ✅ Dropdown for sample vendors
              if (vendors.isNotEmpty)
                DropdownButton<String>(
                  value: null,
                  hint: const Text("Select sample vendor"),
                  items: vendors.map<DropdownMenuItem<String>>((v) {
                    final restaurantName = v['restaurantName']?.toString() ?? '';
                    final email = v['email']?.toString() ?? '';
                    return DropdownMenuItem<String>(
                      value: email,
                      child: Text(restaurantName),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) return;
                    final selected = vendors.firstWhere(
                      (v) => v['email'] == value,
                    );
                    restaurantNameController.text = selected['restaurantName'] ?? '';
                    emailController.text = selected['email'] ?? '';
                    passwordController.text = selected['password'] ?? '';
                  },
                ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Create Vendor Account",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/vendor-login'),
                child: const Text(
                  "Already have an account? Log In",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
