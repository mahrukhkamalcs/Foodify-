import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void _signup() async {
    // (Simulated signup)
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
        title: const Text("Customer Sign Up", style: TextStyle(color: Colors.white)),
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
                onPressed: () => Navigator.pushReplacementNamed(context, '/customer-login'),
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
