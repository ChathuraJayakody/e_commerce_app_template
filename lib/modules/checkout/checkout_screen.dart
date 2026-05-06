import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _step = 0; // 0=address, 1=payment, 2=confirm
  String _selectedAddress = '0';
  String _selectedPayment = 'card';
  bool _isPlacingOrder = false;

  final _addresses = [
    {'id': '0', 'name': 'Home', 'address': '123 Luxury Avenue, Suite 400', 'city': 'New York, NY 10001', 'icon': '🏠'},
    {'id': '1', 'name': 'Office', 'address': '456 Business Park, Floor 12', 'city': 'Manhattan, NY 10002', 'icon': '🏢'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: const Padding(padding: EdgeInsets.all(8), child: PremiumBackButton()),
        title: Text('Checkout', style: AppTextStyles.headingLarge),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: _buildStepIndicator(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _step == 0 ? _buildAddressStep() :
                     _step == 1 ? _buildPaymentStep() :
                     _buildConfirmStep(),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    final steps = ['Address', 'Payment', 'Confirm'];
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Row(
        children: steps.asMap().entries.map((e) {
          final i = e.key;
          final isActive = i == _step;
          final isDone = i < _step;
          return Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 28, height: 28,
                            decoration: BoxDecoration(
                              gradient: isActive || isDone ? AppColors.primaryGradient : null,
                              color: isActive || isDone ? null : AppColors.lightGrey,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: isDone
                                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                                  : Text('${i + 1}', style: AppTextStyles.badge.copyWith(
                                      color: isActive ? Colors.white : AppColors.textLight, fontSize: 11)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(e.value, style: AppTextStyles.caption.copyWith(
                          color: isActive ? AppColors.royalBlue : isDone ? AppColors.successGreen : AppColors.textLight,
                          fontWeight: isActive || isDone ? FontWeight.w600 : FontWeight.w400, fontSize: 10)),
                    ],
                  ),
                ),
                if (i < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2,
                      margin: const EdgeInsets.only(bottom: 18),
                      decoration: BoxDecoration(
                        gradient: isDone ? AppColors.primaryGradient : null,
                        color: isDone ? null : AppColors.borderGrey,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAddressStep() {
    return SingleChildScrollView(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery Address', style: AppTextStyles.headingMedium),
          const SizedBox(height: 4),
          Text('Where should we deliver your order?', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          ..._addresses.map((addr) => GestureDetector(
            onTap: () => setState(() => _selectedAddress = addr['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedAddress == addr['id'] ? AppColors.royalBlue : AppColors.borderGrey,
                  width: _selectedAddress == addr['id'] ? 2 : 1,
                ),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      color: _selectedAddress == addr['id'] ? AppColors.royalBlueSurface : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(addr['icon']!, style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(addr['name']!, style: AppTextStyles.labelLarge.copyWith(fontSize: 14)),
                            if (_selectedAddress == addr['id']) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(color: AppColors.royalBlueSurface, borderRadius: BorderRadius.circular(6)),
                                child: Text('Selected', style: AppTextStyles.caption.copyWith(color: AppColors.royalBlue, fontWeight: FontWeight.w600, fontSize: 9)),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(addr['address']!, style: AppTextStyles.bodySmall.copyWith(fontSize: 12)),
                        Text(addr['city']!, style: AppTextStyles.bodySmall.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(
                    _selectedAddress == addr['id'] ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                    color: _selectedAddress == addr['id'] ? AppColors.royalBlue : AppColors.borderGrey,
                  ),
                ],
              ),
            ),
          )).toList(),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => _showAddAddressSheet(),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderGrey, style: BorderStyle.solid),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.add_rounded, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Text('Add New Address', style: AppTextStyles.labelLarge.copyWith(color: AppColors.royalBlue)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentStep() {
    final methods = [
      {'id': 'card', 'title': 'Credit / Debit Card', 'subtitle': 'Visa, MasterCard, Amex', 'icon': '💳'},
      {'id': 'paypal', 'title': 'PayPal', 'subtitle': 'Fast & Secure', 'icon': '🅿'},
      {'id': 'apple', 'title': 'Apple Pay', 'subtitle': 'Touch ID / Face ID', 'icon': '🍎'},
      {'id': 'cod', 'title': 'Cash on Delivery', 'subtitle': 'Pay when it arrives', 'icon': '💵'},
    ];
    return SingleChildScrollView(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Method', style: AppTextStyles.headingMedium),
          const SizedBox(height: 4),
          Text('Choose how you\'d like to pay', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          ...methods.map((m) => GestureDetector(
            onTap: () => setState(() => _selectedPayment = m['id']!),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _selectedPayment == m['id'] ? AppColors.royalBlue : AppColors.borderGrey,
                  width: _selectedPayment == m['id'] ? 2 : 1,
                ),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Row(
                children: [
                  Container(
                    width: 46, height: 46,
                    decoration: BoxDecoration(
                      color: _selectedPayment == m['id'] ? AppColors.royalBlueSurface : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(child: Text(m['icon']!, style: const TextStyle(fontSize: 22))),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m['title']!, style: AppTextStyles.labelLarge.copyWith(fontSize: 14)),
                        Text(m['subtitle']!, style: AppTextStyles.bodySmall.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                  Icon(
                    _selectedPayment == m['id'] ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                    color: _selectedPayment == m['id'] ? AppColors.royalBlue : AppColors.borderGrey,
                  ),
                ],
              ),
            ),
          )).toList(),
          if (_selectedPayment == 'card') _buildCardForm(),
        ],
      ),
    );
  }

  Widget _buildCardForm() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.royalBlueSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.royalBlue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card Details', style: AppTextStyles.labelLarge.copyWith(color: AppColors.royalBlue)),
          const SizedBox(height: 14),
          PremiumTextField(hint: '4242 4242 4242 4242', label: 'Card Number',
              keyboardType: TextInputType.number,
              prefixIcon: const Icon(Icons.credit_card_rounded, color: AppColors.textLight, size: 20)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: PremiumTextField(hint: 'MM / YY', label: 'Expiry', keyboardType: TextInputType.number)),
              const SizedBox(width: 12),
              Expanded(child: PremiumTextField(hint: '•••', label: 'CVV', isPassword: true, keyboardType: TextInputType.number)),
            ],
          ),
          const SizedBox(height: 12),
          PremiumTextField(hint: 'John Doe', label: 'Cardholder Name',
              prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textLight, size: 20)),
        ],
      ),
    );
  }

  Widget _buildConfirmStep() {
    final ctrl = Get.find<AppController>();
    final addr = _addresses.firstWhere((a) => a['id'] == _selectedAddress);
    return SingleChildScrollView(
      key: const ValueKey(2),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: AppTextStyles.headingMedium),
          const SizedBox(height: 4),
          Text('Review your order before placing', style: AppTextStyles.bodyMedium),
          const SizedBox(height: 20),
          // Items
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${ctrl.cartCount} Items', style: AppTextStyles.headingSmall),
                const SizedBox(height: 12),
                ...ctrl.cartItems.take(3).map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(8)),
                          child: const Center(child: Text('🛍️', style: TextStyle(fontSize: 18)))),
                      const SizedBox(width: 10),
                      Expanded(child: Text(item.product.name, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis)),
                      Text('x${item.quantity}', style: AppTextStyles.caption),
                      const SizedBox(width: 8),
                      Text('\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                          style: AppTextStyles.priceSmall.copyWith(fontSize: 12)),
                    ],
                  ),
                )).toList(),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _SummaryCard(icon: '📍', title: 'Delivery Address', subtitle: '${addr['address']}, ${addr['city']}'),
          const SizedBox(height: 12),
          _SummaryCard(icon: '💳', title: 'Payment Method',
              subtitle: _selectedPayment == 'card' ? 'Credit / Debit Card' : _selectedPayment == 'paypal' ? 'PayPal' : _selectedPayment == 'apple' ? 'Apple Pay' : 'Cash on Delivery'),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
            child: Column(
              children: [
                _SummaryRow('Subtotal', '\$${ctrl.cartTotal.toStringAsFixed(2)}'),
                const SizedBox(height: 8),
                _SummaryRow('Shipping', '\$4.99'),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total', style: AppTextStyles.headingSmall),
                    Text('\$${(ctrl.cartTotal + 4.99).toStringAsFixed(2)}', style: AppTextStyles.priceLarge),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: Row(
        children: [
          if (_step > 0) ...[
            GestureDetector(
              onTap: () => setState(() => _step--),
              child: Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.arrow_back_rounded, color: AppColors.textDark),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: PremiumButton(
              text: _step == 2 ? '🎉  Place Order' : 'Continue  →',
              isLoading: _isPlacingOrder,
              onTap: () async {
                if (_step < 2) {
                  setState(() => _step++);
                } else {
                  setState(() => _isPlacingOrder = true);
                  await Future.delayed(const Duration(seconds: 2));
                  setState(() => _isPlacingOrder = false);
                  _showOrderSuccess();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderSuccess() {
    Get.find<AppController>().clearCart();
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.1), shape: BoxShape.circle),
                child: const Center(child: Text('🎉', style: TextStyle(fontSize: 40))),
              ),
              const SizedBox(height: 20),
              Text('Order Placed!', style: AppTextStyles.displaySmall),
              const SizedBox(height: 8),
              Text('Your order has been confirmed.\nEstimated delivery: 3-5 business days',
                  style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(child: OutlinedPremiumButton(text: 'Track Order', height: 46,
                    onTap: () { Get.back(); Get.toNamed(AppRoutes.orderTracking); })),
                const SizedBox(width: 10),
                Expanded(child: PremiumButton(text: 'Shop More', height: 46,
                    onTap: () { Get.back(); Get.offAllNamed(AppRoutes.main); })),
              ]),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void _showAddAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.borderGrey, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text('Add New Address', style: AppTextStyles.headingMedium),
            const SizedBox(height: 20),
            PremiumTextField(hint: 'Full Name', label: 'Name', prefixIcon: const Icon(Icons.person_outline_rounded, color: AppColors.textLight, size: 20)),
            const SizedBox(height: 12),
            PremiumTextField(hint: 'Street address, apt, suite...', label: 'Address', prefixIcon: const Icon(Icons.location_on_outlined, color: AppColors.textLight, size: 20)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: PremiumTextField(hint: 'City', label: 'City')),
              const SizedBox(width: 12),
              Expanded(child: PremiumTextField(hint: '10001', label: 'Zip Code', keyboardType: TextInputType.number)),
            ]),
            const SizedBox(height: 20),
            PremiumButton(text: 'Save Address', onTap: () => Navigator.pop(context)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String icon, title, subtitle;
  const _SummaryCard({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)]),
    child: Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 24)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.labelSmall.copyWith(color: AppColors.textLight, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w500, fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  final String label, value;
  final Color? valueColor;
  const _SummaryRow(this.label, this.value, {this.valueColor});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 13)),
      Text(value, style: AppTextStyles.labelLarge.copyWith(color: valueColor ?? AppColors.textDark, fontSize: 13)),
    ],
  );
}
