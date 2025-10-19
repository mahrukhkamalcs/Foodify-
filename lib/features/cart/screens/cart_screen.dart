import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../checkout/checkout_screen.dart';
import '../widgets/cart_item_tile.dart';

class CartScreen extends StatefulWidget {
  final List<CartItemModel>? initialCartItems;
  final Function(List<CartItemModel>)? onCartUpdated;

  const CartScreen({super.key, this.initialCartItems, this.onCartUpdated});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItemModel> cartItems;

  @override
  void initState() {
    super.initState();
    // Initialize with passed items or empty list
    cartItems =
        widget.initialCartItems != null
            ? List.from(widget.initialCartItems!)
            : [];
  }

  String get restaurantName {
    if (cartItems.isEmpty) return '';
    return cartItems.first.menuItem.restaurantName;
  }

  double get subtotal {
    return cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 2.99;
  double get tax => subtotal * 0.09; // 9% tax
  double get total => subtotal + deliveryFee + tax;

  void _updateCart() {
    // Notify parent screen about cart changes
    if (widget.onCartUpdated != null) {
      widget.onCartUpdated!(cartItems);
    }
  }

  void _increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
      _updateCart();
    });
  }

  void _decreaseQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
        _updateCart();
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
      _updateCart();
    });

    // If cart is empty, pop back
    if (cartItems.isEmpty) {
      Navigator.pop(context);
    }
  }

  void _proceedToCheckout() {
    if (cartItems.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proceeding to checkout...'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CheckoutScreen(cartItems: cartItems)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _updateCart();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () {
              _updateCart();
              Navigator.pop(context);
            },
          ),
          title: const Text('Your Cart', style: AppTextStyles.h3),
          centerTitle: true,
        ),
        body: cartItems.isEmpty ? _buildEmptyCart() : _buildCartContent(),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: AppColors.textHint,
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          Text(
            'Your cart is empty',
            style: AppTextStyles.h3.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            'Add items to get started',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXLarge),
          PrimaryButton(
            text: 'Browse Menu',
            onPressed: () => Navigator.pop(context),
            width: 200,
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Restaurant Header
                _buildRestaurantHeader(),
                const SizedBox(height: AppDimensions.paddingLarge),

                // Cart Items
                ...List.generate(
                  cartItems.length,
                  (index) => CartItemTile(
                    cartItem: cartItems[index],
                    onIncrease: () => _increaseQuantity(index),
                    onDecrease: () => _decreaseQuantity(index),
                    onRemove: () => _removeItem(index),
                  ),
                ),

                const SizedBox(height: AppDimensions.paddingLarge),

                // Price Breakdown
                _buildPriceBreakdown(),
              ],
            ),
          ),
        ),

        // Checkout Button
        _buildCheckoutButton(),
      ],
    );
  }

  Widget _buildRestaurantHeader() {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          child: Container(
            width: 48,
            height: 48,
            color: AppColors.primary.withOpacity(0.1),
            child: const Icon(
              Icons.restaurant,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingMedium),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(restaurantName, style: AppTextStyles.h4),
              Text(
                '${cartItems.length} item${cartItems.length > 1 ? 's' : ''}',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', subtotal),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildPriceRow('Delivery Fee', deliveryFee),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildPriceRow('Tax', tax),
          const Divider(height: AppDimensions.paddingLarge),
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
          style:
              isTotal
                  ? AppTextStyles.h4
                  : AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style:
              isTotal
                  ? AppTextStyles.h4
                  : AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textPrimary,
                  ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: PrimaryButton(
          text: 'Proceed to Checkout',
          onPressed: _proceedToCheckout,
          width: double.infinity,
        ),
      ),
    );
  }
}
