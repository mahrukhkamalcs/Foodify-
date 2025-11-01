import 'package:flutter/material.dart';
import '../../../core/services/order_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/order/order_model.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const String routeName = '/order-success';

  final String orderId;
  final String restaurantName;
  final double totalAmount;
  final String estimatedDeliveryTime;
  final List<CartItemModel> cartItems;

  const OrderSuccessScreen({
    super.key,
    required this.orderId,
    required this.restaurantName,
    required this.totalAmount,
    required this.estimatedDeliveryTime,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Add top spacing
              // ✅ Success Icon
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.15),
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),

              // Title
              Text(
                'Order Placed Successfully!',
                style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Details
              Text(
                'Your order from $restaurantName has been confirmed.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // ✅ Show ordered items with images (limited height)
              if (cartItems.isNotEmpty) ...[
                Container(
                  constraints: const BoxConstraints(
                    maxHeight: 200, // ✅ Limit height to prevent overflow
                  ),
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Order Items (${cartItems.length})',
                        style: AppTextStyles.h4,
                      ),
                      const SizedBox(height: 12),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  // Item image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      item.menuItem.imageUrl,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      errorBuilder: (
                                        context,
                                        error,
                                        stackTrace,
                                      ) {
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          color: AppColors.background,
                                          child: const Icon(
                                            Icons.fastfood,
                                            color: AppColors.textSecondary,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Item details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.menuItem.name,
                                          style: AppTextStyles.bodyMedium
                                              .copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Qty: ${item.quantity}',
                                          style: AppTextStyles.bodySmall
                                              .copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Item price
                                  Text(
                                    '${item.totalPrice.toStringAsFixed(2)}',
                                    style: AppTextStyles.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Order Summary
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.radiusMedium,
                  ),
                ),
                child: Column(
                  children: [
                    _buildRow('Order ID', orderId),
                    _buildRow(
                      'Total Amount',
                      '\$${totalAmount.toStringAsFixed(2)}',
                    ),
                    _buildRow('Est. Delivery', estimatedDeliveryTime),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Save order to service WITH ITEMS ✅
                    final newOrder = Order(
                      id: orderId,
                      restaurantName: restaurantName,
                      status: 'Placed',
                      estimatedDeliveryTime: estimatedDeliveryTime,
                      totalAmount: totalAmount,
                      orderTime: DateTime.now(),
                      items: cartItems, // ✅ CRITICAL: Pass cart items
                    );
                    OrderService().addOrder(newOrder);

                    // Navigate to tracking
                    Navigator.pushNamed(
                      context,
                      '/order-tracking',
                      arguments: {
                        'orderId': orderId,
                        'estimatedDeliveryTime': estimatedDeliveryTime,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMedium,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Track Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // Save order & go home WITH ITEMS ✅
                  final newOrder = Order(
                    id: orderId,
                    restaurantName: restaurantName,
                    status: 'Placed',
                    estimatedDeliveryTime: estimatedDeliveryTime,
                    totalAmount: totalAmount,
                    orderTime: DateTime.now(),
                    items: cartItems, // ✅ CRITICAL: Pass cart items
                  );
                  OrderService().addOrder(newOrder);

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/main',
                    (route) => false,
                  );
                },
                child: const Text(
                  'Go to Home',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 40), // Add bottom spacing
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodyMedium),
          Text(
            value,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
