import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/customer/customer_model.dart';
import '../widgets/custom_text_field.dart';

class CustomerSignupScreen extends StatefulWidget {
  static const routeName = '/customer-signup';
  const CustomerSignupScreen({super.key});

  @override
  State<CustomerSignupScreen> createState() => _CustomerSignupScreenState();
}

class _CustomerSignupScreenState extends State<CustomerSignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<CustomerModel> customers = [];

  // 🟢 Step 1: Load JSON data
  Future<void> loadCustomerData() async {
    final String response =
        await rootBundle.loadString('assets/data/customer_signup.json');
    final data = json.decode(response);
    final List list = data['customers'];

    setState(() {
      customers = list.map((e) => CustomerModel.fromJson(e)).toList();
    });
  }

  // 🟢 Step 2: Initialize on startup
  @override
  void initState() {
    super.initState();
    loadCustomerData();
  }

  // 🟢 Step 3: Simulated signup
  void _signup() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userRole', 'customer');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );
      Navigator.pushReplacementNamed(context, '/customer-login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Customer Sign Up",
            style: TextStyle(color: Colors.white)),
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
                label: "Full Name",
                controller: nameController,
                icon: Icons.person_outline,
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
              const SizedBox(height: 20),

              // 🟢 Example: Load JSON names in a dropdown
              if (customers.isNotEmpty)
                DropdownButton<String>(
                  value: null,
                  hint: const Text("Select from sample users"),
                  items: customers
                      .map((c) => DropdownMenuItem(
                            value: c.fullName,
                            child: Text(c.fullName),
                          ))
                      .toList(),
                  onChanged: (value) {
                    final selected =
                        customers.firstWhere((c) => c.fullName == value);
                    nameController.text = selected.fullName;
                    emailController.text = selected.email;
                    passwordController.text = selected.password;
                  },
                ),

              ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/customer-login'),
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
