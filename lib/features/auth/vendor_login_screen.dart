import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_application_1/data/models/vendor/vendor_login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/widgets/custom_text_field.dart';

class VendorLoginScreen extends StatefulWidget {
  static const routeName = '/vendor-login';
  const VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<VendorLoginModel> vendors = [];
  bool _isLoading = false;

  Future<void> loadVendorData() async {
    final String response =
        await rootBundle.loadString('assets/data/vendor_login.json');
    final data = json.decode(response);
    final List list = data['vendors'];

    setState(() {
      vendors = list.map((e) => VendorLoginModel.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadVendorData();
  }

  Future<void> _saveSession(VendorLoginModel vendor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('vendorId', vendor.id);
    await prefs.setString('vendorEmail', vendor.email);
  }

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter all fields")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    final vendor = vendors.firstWhere(
      (v) => v.email == email && v.password == password,
      orElse: () => VendorLoginModel(id: -1, email: '', password: ''),
    );

    setState(() {
      _isLoading = false;
    });

    if (vendor.id != -1) {
      await _saveSession(vendor);
      Navigator.pushReplacementNamed(context, '/vendor-dashboard');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid email or password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Vendor Login",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 40),
              CustomTextField(
                label: "Email",
                controller: emailController,
                icon: Icons.store_outlined,
              ),
              CustomTextField(
                label: "Password",
                obscureText: true,
                controller: passwordController,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 10),

              if (vendors.isNotEmpty)
                DropdownButton<String>(
                  hint: const Text("Select sample vendor"),
                  value: null,
                  items: vendors
                      .map(
                        (v) => DropdownMenuItem<String>(
                          value: v.email,
                          child: Text(v.email),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    final selected =
                        vendors.firstWhere((v) => v.email == value);
                    emailController.text = selected.email;
                    passwordController.text = selected.password;
                  },
                ),

              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/customer-login'),
                child: const Text(
                  "Login as Customer instead",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, '/vendor-signup'),
                    child: const Text(
                      "Signup",
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
