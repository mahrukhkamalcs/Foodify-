import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/role_selection.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = '/onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  final List<Map<String, String>> pages = [
    {
      'image': 'assets/images/Onboarding.jpg',
      'title': 'Welcome to Foodify',
      'subtitle': 'Discover your favorite meals from multiple vendors in one place.'
    },
    {
      'image': 'assets/images/Food_Delivery.jpg',
      'title': 'Fast Delivery',
      'subtitle': 'Hot and fresh at your doorstep with live tracking.'
    },
    {
      'image': 'assets/images/Logo.png',
      'title': 'One Cart, Many Vendors',
      'subtitle': 'Add items from different vendors and checkout in one go.'
    },
  ];

  void _onNext() {
    if (_pageIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, RoleSelectionScreen.routeName);
    }
  }

  void _onSkip() {
    Navigator.pushReplacementNamed(context, RoleSelectionScreen.routeName);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildIndicator(int index) {
    final bool active = index == _pageIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 22 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.black26,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 16),
                child: TextButton(
                  onPressed: _onSkip,
                  child: const Text('Skip', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _pageIndex = i),
                itemBuilder: (context, index) {
                  final item = pages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(item['image']!, height: 250),
                      const SizedBox(height: 40),
                      Text(item['title']!,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Text(item['subtitle']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Colors.black54)),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: List.generate(pages.length, (i) => _buildIndicator(i))),
                  ElevatedButton(
                    onPressed: _onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(_pageIndex == pages.length - 1 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
