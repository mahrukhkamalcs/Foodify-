import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../core/services/order_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../navigation/main_navigation.dart';

class OrderTrackingScreen extends StatefulWidget {
  final String orderId;
  final String estimatedDeliveryTime;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
    required this.estimatedDeliveryTime,
  });

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  int currentStep = 2; // 0=Placed, 1=Preparing, 2=On the Way, 3=Delivered

  final List<Map<String, dynamic>> orderSteps = [
    {
      'title': 'Order Placed',
      'subtitle': 'We’ve received your order',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Preparing',
      'subtitle': 'Your food is being prepared',
      'icon': Icons.restaurant_menu_outlined,
    },
    {
      'title': 'On the Way',
      'subtitle': 'Our delivery partner is on the move',
      'icon': Icons.delivery_dining,
    },
    {
      'title': 'Delivered',
      'subtitle': 'Order delivered successfully',
      'icon': Icons.home_outlined,
    },
  ];

  void _showCancelOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Cancel Order?'),
            content: const Text(
              'Are you sure you want to cancel this order? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('No, Keep Order'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                ),
                onPressed: () {
                  // TODO: In real app, call cancel API
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order canceled successfully!'),
                    ),
                  );
                  Navigator.of(ctx).pop();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/main',
                    (route) => false,
                  );
                },
                child: const Text('Yes, Cancel'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentStep + 1) / orderSteps.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Track Your Order', style: AppTextStyles.h3),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🚚 Animated Delivery Rider
            Center(
              child: Lottie.asset(
                'assets/animations/delivery.json',
                width: 200,
                height: 200,
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // 📊 Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),

            // 🟢 Order Summary
            _buildOrderSummary(),
            const SizedBox(height: AppDimensions.paddingXLarge),

            // 🔵 Stepper
            _buildOrderStepper(),
            const SizedBox(height: AppDimensions.paddingXLarge),

            // 🚴 Delivery Info
            _buildDeliveryPersonInfo(),
            const SizedBox(height: AppDimensions.paddingLarge),

            // 🏠 Go to Home Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    MainNavigation.routeName,
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                  ),
                ),
                child: const Text(
                  'Go to Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),

            // ❌ Cancel Order Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showCancelOrderDialog(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingMedium,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                  ),
                ),
                child: Text(
                  'Cancel Order',
                  style: TextStyle(
                    color: AppColors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order ID: ${widget.orderId}', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 6),
          Text(
            'Estimated Delivery: ${widget.estimatedDeliveryTime}',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStepper() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(orderSteps.length, (index) {
        final step = orderSteps[index];
        final isCompleted = index <= currentStep;

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isCompleted
                                ? AppColors.primary
                                : Colors.grey.shade300,
                      ),
                      child: Icon(step['icon'], size: 16, color: Colors.white),
                    ),
                    if (index != orderSteps.length - 1)
                      Container(
                        width: 2,
                        height: 50,
                        color:
                            isCompleted
                                ? AppColors.primary
                                : Colors.grey.shade300,
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: AppDimensions.paddingSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step['title'],
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                isCompleted
                                    ? AppColors.textPrimary
                                    : AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          step['subtitle'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDeliveryPersonInfo() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              'https://img.freepik.com/free-photo/emotions-people-concept-headshot-serious-looking-handsome-man-with-beard-looking-confident-determined_1258-26730.jpg',
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ramesh Thapa',
                  style: AppTextStyles.h4.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Your Delivery Partner',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: AppColors.primary),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Calling your delivery partner...'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
