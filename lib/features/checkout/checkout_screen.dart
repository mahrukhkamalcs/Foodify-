import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/app_dimensions.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../data/models/cart/cart_item_model.dart';
import '../../../data/models/checkout/address_model.dart';
import '../../../data/models/checkout/payment_method_model.dart';
import '../../core/widgets/address_selection_card.dart';
import '../../core/widgets/order_summary_section.dart';
import '../../core/widgets/payment_method_card.dart';
import '../payment/screens/payment_screen.dart';


class CheckoutScreen extends StatefulWidget {
  final List<CartItemModel> cartItems;

  const CheckoutScreen({
    super.key,
    required this.cartItems, required double total, required double totalPrice,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Sample addresses - Replace with actual user addresses
  final List<AddressModel> _addresses = [
    AddressModel(
      id: '1',
      label: 'Home',
      fullAddress: '123 Main Street, Apt 4B,Nepal, Kathmandu',
      street: '123 Main Street',
      city: 'Kathmandu',
      state: 'Bagmati',
      zipCode: '10001',
      apartment: 'Apt 4B',
      instructions: 'Ring doorbell twice',
      isDefault: true,
    ),
    AddressModel(
      id: '2',
      label: 'Work',
      fullAddress: '456 Office Plaza, Suite 200, Nepal, Kathmandu',
      street: '456 Office Plaza',
      city: 'New York',
      state: 'NY',
      zipCode: '10002',
      apartment: 'Suite 200',
    ),
  ];

  // Sample payment methods
  final List<PaymentMethodModel> _paymentMethods = [
    PaymentMethodModel(
      id: '1',
      type: PaymentType.card,
      displayName: 'Visa',
      cardNumber: '4242',
      cardType: 'Visa',
      expiryDate: '12/25',
      isDefault: true,
    ),
    PaymentMethodModel(
      id: '2',
      type: PaymentType.card,
      displayName: 'Mastercard',
      cardNumber: '8888',
      cardType: 'Mastercard',
      expiryDate: '06/26',
    ),
    PaymentMethodModel(
      id: '3',
      type: PaymentType.cash,
      displayName: 'Cash on Delivery',
    ),
  ];

  late AddressModel _selectedAddress;
  late PaymentMethodModel _selectedPaymentMethod;
  String _deliveryInstructions = '';

  @override
  void initState() {
    super.initState();
    _selectedAddress = _addresses.firstWhere(
      (addr) => addr.isDefault,
      orElse: () => _addresses.first,
    );
    _selectedPaymentMethod = _paymentMethods.firstWhere(
      (pm) => pm.isDefault,
      orElse: () => _paymentMethods.first,
    );
  }

  double get subtotal {
    return widget.cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  }

  double get deliveryFee => 2.99;
  double get tax => subtotal * 0.09;
  double get total => subtotal + deliveryFee + tax;

  void _proceedToPayment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentScreen(
          cartItems: widget.cartItems,
          deliveryAddress: _selectedAddress,
          paymentMethod: _selectedPaymentMethod,
          subtotal: subtotal,
          deliveryFee: deliveryFee,
          tax: tax,
          total: total,
          deliveryInstructions: _deliveryInstructions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout', style: AppTextStyles.h3),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Address Section
                  _buildSectionHeader('Delivery Address'),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  ..._addresses.map((address) => AddressSelectionCard(
                        address: address,
                        isSelected: _selectedAddress.id == address.id,
                        onTap: () {
                          setState(() {
                            _selectedAddress = address;
                          });
                        },
                      )),
                  
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Delivery Instructions
                  _buildSectionHeader('Delivery Instructions (Optional)'),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Add any special instructions...',
                      hintStyle: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textHint,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium,
                        ),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(
                        AppDimensions.paddingMedium,
                      ),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      _deliveryInstructions = value;
                    },
                  ),

                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Payment Method Section
                  _buildSectionHeader('Payment Method'),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  ..._paymentMethods.map((method) => PaymentMethodCard(
                        paymentMethod: method,
                        isSelected: _selectedPaymentMethod.id == method.id,
                        onTap: () {
                          setState(() {
                            _selectedPaymentMethod = method;
                          });
                        },
                      )),

                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Order Summary
                  _buildSectionHeader('Order Summary'),
                  const SizedBox(height: AppDimensions.paddingSmall),
                  OrderSummarySection(
                    cartItems: widget.cartItems,
                    subtotal: subtotal,
                    deliveryFee: deliveryFee,
                    tax: tax,
                    total: total,
                  ),

                  const SizedBox(height: AppDimensions.paddingXLarge),
                ],
              ),
            ),
          ),

          // Place Order Button
          _buildPlaceOrderButton(),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.h4,
    );
  }

  Widget _buildPlaceOrderButton() {
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
          text: 'Place Order • \$${total.toStringAsFixed(2)}',
          onPressed: _proceedToPayment,
          width: double.infinity,
        ),
      ),
    );
  }
}