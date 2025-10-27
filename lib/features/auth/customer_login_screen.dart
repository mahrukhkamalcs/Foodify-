import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/customer/customer_login_model.dart';
import '../../navigation/main_navigation.dart';
import '../auth/widgets/custom_text_field.dart';

class CustomerLoginScreen extends StatefulWidget {
  static const routeName = '/customer-login';
  const CustomerLoginScreen({super.key});

  @override
  State<CustomerLoginScreen> createState() => _CustomerLoginScreenState();
}

class _CustomerLoginScreenState extends State<CustomerLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  List<CustomerLoginModel> customers = [];
  bool _isLoading = false;

  Future<void> loadLoginData() async {
    final String response =
        await rootBundle.loadString('assets/data/customer_login.json');
    final data = json.decode(response);
    final List list = data['customers'];

    setState(() {
      customers = list.map((e) => CustomerLoginModel.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadLoginData();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _saveSession(CustomerLoginModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', user.id);
    await prefs.setString('userEmail', user.email);
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

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid email")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Check credentials against sample users
    final user = customers.firstWhere(
      (c) => c.email == email && c.password == password,
      orElse: () => CustomerLoginModel(id: -1, email: '', password: ''),
    );

    setState(() {
      _isLoading = false;
    });

    if (user.id != -1) {
      await _saveSession(user);
      Navigator.pushReplacementNamed(context, MainNavigation.routeName);
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
                "Customer Login",
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
                icon: Icons.email_outlined,
              ),
              CustomTextField(
                label: "Password",
                obscureText: true,
                controller: passwordController,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 10),

              if (customers.isNotEmpty)
                DropdownButton<String>(
                  hint: const Text("Select sample user"),
                  value: null,
                  items: customers
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.email,
                          child: Text(c.email),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    final selected =
                        customers.firstWhere((c) => c.email == value);
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
                onPressed: () => Navigator.pushNamed(context, '/vendor-login'),
                child: const Text(
                  "Login as Vendor instead",
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
                        Navigator.pushNamed(context, '/customer-signup'),
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
