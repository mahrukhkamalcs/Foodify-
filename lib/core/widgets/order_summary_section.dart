import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/cart/cart_item_model.dart';

class OrderSummarySection extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;

  const OrderSummarySection({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        children: [
          // Items List
          ...cartItems.map((item) => Padding(
                padding: const EdgeInsets.only(
                  bottom: AppDimensions.paddingSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            '${item.quantity}x',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: AppDimensions.paddingSmall),
                          Expanded(
                            child: Text(
                              item.menuItem.name,
                              style: AppTextStyles.bodyMedium,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              )),

          const Divider(height: AppDimensions.paddingLarge),

          // Price Breakdown
          _buildPriceRow('Subtotal', subtotal),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildPriceRow('Delivery Fee', deliveryFee),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildPriceRow('Tax', tax),

          const Divider(height: AppDimensions.paddingLarge),

          // Total
          _buildPriceRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isTotal
              ? AppTextStyles.h4
              : AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: isTotal
              ? AppTextStyles.h4
              : AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                ),
        ),
      ],
    );
  }
}