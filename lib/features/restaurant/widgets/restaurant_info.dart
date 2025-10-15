import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/restaurant/restaurant_model.dart';

class RestaurantInfo extends StatelessWidget {
  final RestaurantModel restaurant;

  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.name, style: AppTextStyles.h2.copyWith(fontSize: 24)),
          const SizedBox(height: AppDimensions.paddingSmall),
          Row(
            children: [
              // Rating
              const Icon(Icons.star, size: 18, color: AppColors.secondary),
              const SizedBox(width: 4),
              Text(
                restaurant.rating.toString(),
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),

              // Delivery Time
              const Icon(
                Icons.access_time,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                restaurant.deliveryTime,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingMedium),

              // Delivery Fee
              const Icon(
                Icons.delivery_dining,
                size: 18,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                '\$${restaurant.deliveryFee.toStringAsFixed(2)} Delivery Fee',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
