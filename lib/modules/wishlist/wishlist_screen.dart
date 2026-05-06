import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/constants/app_dimensions.dart';
import '../../widgets/common/common_widgets.dart';
import '../../widgets/product/product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<AppController>();
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Wishlist', style: AppTextStyles.headingLarge),
        actions: [
          Obx(() => ctrl.wishlistIds.isNotEmpty
              ? TextButton(
                  onPressed: () => ctrl.wishlistIds.clear(),
                  child: Text('Clear All',
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.errorRed, fontWeight: FontWeight.w600)),
                )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        final products = ctrl.wishlistProducts;
        if (products.isEmpty) {
          return EmptyStateWidget(
            emoji: '❤️',
            title: 'Your Wishlist is Empty',
            subtitle: 'Save your favourite products here to revisit and purchase later.',
            buttonText: 'Explore Products',
            onButtonTap: () => ctrl.setNavIndex(0),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
              child: Row(
                children: [
                  Text('${products.length} saved items',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMedium, fontSize: 13)),
                  const Spacer(),
                  GestureDetector(
                    onTap: () { for (var p in products) ctrl.addToCart(p); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(10)),
                      child: Text('Add All to Cart', style: AppTextStyles.badge.copyWith(fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 14, mainAxisSpacing: 14, childAspectRatio: 0.68,
                ),
                itemCount: products.length,
                itemBuilder: (_, i) => ProductCard(product: products[i]),
              ),
            ),
          ],
        );
      }),
    );
  }
}
