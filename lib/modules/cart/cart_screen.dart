import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../app/routes/app_routes.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _couponController = TextEditingController();
  String? _appliedCoupon;
  double _discount = 0;
  bool _couponLoading = false;

  final Map<String, double> _validCoupons = {
    'LUXE10': 10.0,
    'PREMIUM20': 20.0,
    'WELCOME15': 15.0,
  };

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon() async {
    final code = _couponController.text.toUpperCase().trim();
    setState(() => _couponLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      _couponLoading = false;
      if (_validCoupons.containsKey(code)) {
        _appliedCoupon = code;
        _discount = _validCoupons[code]!;
        Get.snackbar('🎉 Coupon Applied!', 'You saved \$$_discount with code $code',
            backgroundColor: AppColors.successGreen, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16), borderRadius: 12);
      } else {
        Get.snackbar('Invalid Coupon', 'This coupon code is not valid.',
            backgroundColor: AppColors.errorRed, colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16), borderRadius: 12);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppController>();
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text('My Cart', style: AppTextStyles.headingLarge),
            const SizedBox(width: 8),
            Obx(() => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${ctrl.cartCount}',
                  style: AppTextStyles.badge.copyWith(fontSize: 11)),
            )),
          ],
        ),
        actions: [
          Obx(() {
            if (ctrl.cartItems.isEmpty) return const SizedBox();
            return TextButton(
              onPressed: () => _showClearCartDialog(ctrl),
              child: Text('Clear All',
                  style: AppTextStyles.labelSmall
                      .copyWith(color: AppColors.errorRed, fontWeight: FontWeight.w600)),
            );
          }),
        ],
      ),
      body: Obx(() {
        if (ctrl.cartItems.isEmpty) {
          return EmptyStateWidget(
            emoji: '🛒',
            title: 'Your Cart is Empty',
            subtitle: 'Looks like you haven\'t added anything yet. Start exploring premium products!',
            buttonText: 'Browse Products',
            onButtonTap: () => ctrl.setNavIndex(0),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                children: [
                  ...ctrl.cartItems.asMap().entries.map((e) =>
                      _CartItemCard(index: e.key, item: e.value, controller: ctrl)),
                  const SizedBox(height: 16),
                  _buildCouponSection(),
                  const SizedBox(height: 16),
                  _buildDeliveryOptions(),
                  const SizedBox(height: 16),
                  _buildOrderSummary(ctrl),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            _buildCheckoutBar(ctrl),
          ],
        );
      }),
    );
  }

  Widget _buildCouponSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.royalBlueSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.local_offer_outlined, color: AppColors.royalBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Text('Promo Code', style: AppTextStyles.headingSmall),
              const Spacer(),
              if (_appliedCoupon != null)
                GestureDetector(
                  onTap: () => setState(() { _appliedCoupon = null; _discount = 0; _couponController.clear(); }),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.errorRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Remove', style: AppTextStyles.caption.copyWith(color: AppColors.errorRed, fontWeight: FontWeight.w600)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          if (_appliedCoupon != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.successGreen.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.successGreen.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline_rounded, color: AppColors.successGreen, size: 18),
                  const SizedBox(width: 8),
                  Text('$_appliedCoupon applied • -\$$_discount off',
                      style: AppTextStyles.labelMedium.copyWith(color: AppColors.successGreen, fontWeight: FontWeight.w600)),
                ],
              ),
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    textCapitalization: TextCapitalization.characters,
                    style: AppTextStyles.inputText,
                    decoration: InputDecoration(
                      hintText: 'Enter promo code',
                      hintStyle: AppTextStyles.inputHint,
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.royalBlue)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: _couponLoading ? null : _applyCoupon,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _couponLoading
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text('Apply', style: AppTextStyles.buttonMedium.copyWith(fontSize: 13)),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            children: _validCoupons.keys.map((code) => GestureDetector(
              onTap: () { _couponController.text = code; },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.borderGrey),
                ),
                child: Text(code, style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, fontSize: 10)),
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppColors.royalBlueSurface, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.local_shipping_outlined, color: AppColors.royalBlue, size: 18),
              ),
              const SizedBox(width: 10),
              Text('Delivery Options', style: AppTextStyles.headingSmall),
            ],
          ),
          const SizedBox(height: 12),
          _DeliveryOption(icon: '⚡', title: 'Express Delivery', subtitle: 'Arrives in 1-2 business days', price: '\$9.99', isSelected: false),
          const SizedBox(height: 8),
          _DeliveryOption(icon: '📦', title: 'Standard Delivery', subtitle: 'Arrives in 3-5 business days', price: '\$4.99', isSelected: true),
          const SizedBox(height: 8),
          _DeliveryOption(icon: '🎁', title: 'Free Delivery', subtitle: 'Arrives in 7-10 business days', price: 'FREE', isSelected: false),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(AppController ctrl) {
    final subtotal = ctrl.cartTotal;
    final shipping = 4.99;
    final totalDiscount = ctrl.cartDiscount + _discount;
    final total = subtotal + shipping - _discount;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: AppTextStyles.headingSmall),
          const SizedBox(height: 16),
          _SummaryRow('Subtotal (${ctrl.cartCount} items)', '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 10),
          _SummaryRow('Shipping', '\$${shipping.toStringAsFixed(2)}'),
          if (totalDiscount > 0) ...[
            const SizedBox(height: 10),
            _SummaryRow('Discount', '-\$${totalDiscount.toStringAsFixed(2)}', valueColor: AppColors.successGreen),
          ],
          const SizedBox(height: 14),
          Container(height: 1, color: AppColors.midGrey),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyles.headingSmall.copyWith(fontSize: 16)),
              Text('\$${total.toStringAsFixed(2)}',
                  style: AppTextStyles.priceLarge.copyWith(fontSize: 20)),
            ],
          ),
          if (totalDiscount > 0) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: AppColors.successGreen.withOpacity(0.08), borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.savings_outlined, color: AppColors.successGreen, size: 14),
                  const SizedBox(width: 6),
                  Text('You\'re saving \$${totalDiscount.toStringAsFixed(2)} on this order!',
                      style: AppTextStyles.caption.copyWith(color: AppColors.successGreen, fontWeight: FontWeight.w600, fontSize: 11)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCheckoutBar(AppController ctrl) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, -4))],
      ),
      child: PremiumButton(
        text: 'Proceed to Checkout  →',
        onTap: () => Get.toNamed(AppRoutes.checkout),
        suffixIcon: null,
      ),
    );
  }

  void _showClearCartDialog(AppController ctrl) {
    Get.dialog(AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: const Text('Clear Cart?', style: AppTextStyles.headingMedium),
      content: Text('Remove all items from your cart?', style: AppTextStyles.bodyMedium),
      actions: [
        TextButton(onPressed: () => Get.back(), child: Text('Cancel', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textMedium))),
        TextButton(onPressed: () { ctrl.clearCart(); Get.back(); }, child: Text('Clear', style: AppTextStyles.labelMedium.copyWith(color: AppColors.errorRed))),
      ],
    ));
  }
}

// ── Cart Item Card ─────────────────────────────────────────────
class _CartItemCard extends StatelessWidget {
  final int index;
  final CartItem item;
  final AppController controller;

  const _CartItemCard({required this.index, required this.item, required this.controller});

  @override
  Widget build(BuildContext context) {
    const emojis = {'1':'📱','2':'📱','3':'👟','4':'⌚','5':'👔','6':'🎧','7':'💻','8':'💄'};
    return Dismissible(
      key: Key('cart_${item.product.id}_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(color: AppColors.errorRed, borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
      ),
      onDismissed: (_) => controller.removeFromCart(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
        ),
        child: Row(
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(12)),
              child: Center(child: Text(emojis[item.product.id] ?? '🛍️', style: const TextStyle(fontSize: 40))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.name, style: AppTextStyles.labelLarge.copyWith(fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      _Chip(item.color),
                      const SizedBox(width: 6),
                      _Chip(item.size),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('\$${item.product.price.toStringAsFixed(2)}',
                          style: AppTextStyles.priceSmall.copyWith(fontSize: 14)),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            _MiniQtyBtn(icon: Icons.remove_rounded, onTap: () => controller.updateCartQuantity(index, item.quantity - 1)),
                            SizedBox(width: 28, child: Center(child: Text('${item.quantity}', style: AppTextStyles.labelLarge.copyWith(fontSize: 13)))),
                            _MiniQtyBtn(icon: Icons.add_rounded, onTap: () => controller.updateCartQuantity(index, item.quantity + 1)),
                          ],
                        ),
                      ),
                    ],
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

class _Chip extends StatelessWidget {
  final String label;
  const _Chip(this.label);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(color: AppColors.lightGrey, borderRadius: BorderRadius.circular(6)),
    child: Text(label, style: AppTextStyles.caption.copyWith(fontSize: 10, color: AppColors.textMedium)),
  );
}

class _MiniQtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _MiniQtyBtn({required this.icon, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 28, height: 28,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Icon(icon, size: 15, color: AppColors.elegantBlack),
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
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

class _DeliveryOption extends StatelessWidget {
  final String icon, title, subtitle, price;
  final bool isSelected;
  const _DeliveryOption({required this.icon, required this.title, required this.subtitle, required this.price, required this.isSelected});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: isSelected ? AppColors.royalBlueSurface : AppColors.lightGrey,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: isSelected ? AppColors.royalBlue.withOpacity(0.3) : Colors.transparent),
    ),
    child: Row(
      children: [
        Text(icon, style: const TextStyle(fontSize: 20)),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: isSelected ? AppColors.royalBlue : AppColors.textDark)),
              Text(subtitle, style: AppTextStyles.caption.copyWith(fontSize: 10)),
            ],
          ),
        ),
        Text(price, style: AppTextStyles.labelMedium.copyWith(color: isSelected ? AppColors.royalBlue : AppColors.textDark, fontWeight: FontWeight.w700, fontSize: 12)),
        const SizedBox(width: 8),
        Container(
          width: 18, height: 18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: isSelected ? AppColors.royalBlue : AppColors.borderGrey, width: 2),
            color: isSelected ? AppColors.royalBlue : Colors.transparent,
          ),
          child: isSelected ? const Icon(Icons.check_rounded, size: 10, color: Colors.white) : null,
        ),
      ],
    ),
  );
}
