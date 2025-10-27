import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedAddressesScreen extends StatefulWidget {
  static const routeName = '/saved-addresses';
  const SavedAddressesScreen({super.key});

  @override
  State<SavedAddressesScreen> createState() => _SavedAddressesScreenState();
}

class _SavedAddressesScreenState extends State<SavedAddressesScreen> {
  String userEmail = '';
  String userName = 'Customer';
  List<String> addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail') ?? '';
    final name = prefs.getString('userName') ?? 'Customer';

    // Mock addresses
    final mockAddresses = [
      '123 Main St, City, Country',
      '456 Second St, City, Country',
    ];

    setState(() {
      userEmail = email;
      userName = name;
      addresses = mockAddresses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Addresses')),
      body: addresses.isEmpty
          ? const Center(child: Text('No addresses found'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(addresses[index]),
                  subtitle: Text('User: $userName ($userEmail)'),
                  leading: const Icon(Icons.location_on),
                );
              },
            ),
    );
  }
}
