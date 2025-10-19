import 'package:flutter/material.dart';
import 'dart:async';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/checkout/address_model.dart';
import '../../../data/models/checkout/payment_method_model.dart';
import 'order_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;
  final AddressModel deliveryAddress;
  final PaymentMethodModel paymentMethod;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final String? deliveryInstructions;

  const PaymentScreen({
    super.key,
    required this.cartItems,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    this.deliveryInstructions,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  bool _isProcessing = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _processPayment();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _processPayment() async {
    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      // Navigate to success screen after a short delay
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => OrderSuccessScreen(
                  orderId: 'ORD${DateTime.now().millisecondsSinceEpoch}',
                  restaurantName:
                      widget.cartItems.isNotEmpty
                          ? widget.cartItems.first.menuItem.restaurantName
                          : 'Restaurant', // ✅ Get restaurant name from cart items
                  totalAmount: widget.total,
                  estimatedDeliveryTime: '30-40 min',
                  cartItems: widget.cartItems, // ✅ Pass cart items
                ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Payment Icon
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _isProcessing
                              ? AppColors.primary.withOpacity(0.1)
                              : AppColors.success.withOpacity(0.1),
                    ),
                    child: Icon(
                      _isProcessing ? Icons.payment : Icons.check_circle,
                      size: 60,
                      color:
                          _isProcessing ? AppColors.primary : AppColors.success,
                    ),
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingXLarge),

                // Status Text
                Text(
                  _isProcessing
                      ? 'Processing Payment...'
                      : 'Payment Successful!',
                  style: AppTextStyles.h2,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.paddingMedium),

                // Description
                Text(
                  _isProcessing
                      ? 'Please wait while we process your payment'
                      : 'Your order has been placed successfully!',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppDimensions.paddingXLarge),

                // Loading Indicator
                if (_isProcessing)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),

                const SizedBox(height: AppDimensions.paddingXLarge),

                // Payment Details Container
                Container(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusMedium,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Subtotal', widget.subtotal),
                      const SizedBox(height: 6),
                      _buildDetailRow('Delivery Fee', widget.deliveryFee),
                      const SizedBox(height: 6),
                      _buildDetailRow('Tax', widget.tax),
                      const Divider(height: 20, thickness: 1),
                      _buildDetailRow('Total', widget.total, isBold: true),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingXLarge),

                // Back to Home or Orders Button (after success)
                if (!_isProcessing)
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      'Back to Home',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Helper widget to display payment summary rows
  Widget _buildDetailRow(String label, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
