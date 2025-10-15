import 'package:flutter/material.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../data/models/restaurant/category_model.dart';
import 'category_chip.dart';

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySection({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingSmall),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryChip(
            category: category,
            isSelected: selectedCategory == category.name,
            onTap: () => onCategorySelected(category.name),
          );
        },
      ),
    );
  }
}
