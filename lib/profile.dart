import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Account",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image + Name
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/girl.jpg'),
                  ),
                  SizedBox(height: 10),
                  Text("Sophia Carter",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  Text("⭐ 4.9 · 100+ ratings",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 25),

            const Text("Past Orders",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            // Past Orders
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/burger - Copy (3).jpg', width: 50, height: 50),
              ),
              title: const Text("Order #12345"),
              subtitle: const Text("Burger Place • 2 items"),
              trailing: const Text("\$25.50",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset('assets/pizza.jpg', width: 50, height: 50),
              ),
              title: const Text("Order #67890"),
              subtitle: const Text("Pizza Joint • 3 items"),
              trailing: const Text("\$32.75",
                  style: TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),

            const Text("Saved Addresses",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.home, color: Colors.orange),
              title: Text("Home"),
              subtitle: Text("123 Main St, Apt 4B"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.work, color: Colors.orange),
              title: Text("Work"),
              subtitle: Text("456 Oak Ave, Suite 200"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const SizedBox(height: 20),

            const Text("Settings",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),

            const ListTile(
              leading: Icon(Icons.credit_card, color: Colors.orange),
              title: Text("Payment Methods"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.notifications, color: Colors.orange),
              title: Text("Notifications"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const ListTile(
              leading: Icon(Icons.help_outline, color: Colors.orange),
              title: Text("Help"),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 2) {
            Navigator.pop(context);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
