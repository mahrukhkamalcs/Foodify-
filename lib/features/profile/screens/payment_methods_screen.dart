import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethodsScreen extends StatefulWidget {
  static const routeName = '/payment-methods';
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String userEmail = '';
  String userName = 'Customer';
  List<String> paymentMethods = [];

  @override
  void initState() {
    super.initState();
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail') ?? '';
    final name = prefs.getString('userName') ?? 'Customer';

    // Mock payment methods
    final mockPayments = [
      'Visa **** 1234',
      'MasterCard **** 5678',
      'PayPal: user@example.com',
    ];

    setState(() {
      userEmail = email;
      userName = name;
      paymentMethods = mockPayments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      body: paymentMethods.isEmpty
          ? const Center(child: Text('No payment methods found'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: paymentMethods.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(paymentMethods[index]),
                  subtitle: Text('User: $userName ($userEmail)'),
                  leading: const Icon(Icons.payment),
                );
              },
            ),
    );
  }
}
