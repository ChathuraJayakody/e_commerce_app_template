import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/bindings/app_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/cart/cart_screen.dart';
import '../../modules/wishlist/wishlist_screen.dart';
import '../../modules/profile/profile_screen.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    final pages = [
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.currentNavIndex.value,
            children: pages,
          ),
          bottomNavigationBar: _buildBottomNav(controller),
        ));
  }

  Widget _buildBottomNav(AppController controller) {
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Home',
                    index: 0,
                    currentIndex: controller.currentNavIndex.value,
                    onTap: () => controller.setNavIndex(0),
                  ),
                  _NavItem(
                    icon: Icons.grid_view_outlined,
                    activeIcon: Icons.grid_view_rounded,
                    label: 'Category',
                    index: 1,
                    currentIndex: controller.currentNavIndex.value,
                    onTap: () => controller.setNavIndex(1),
                  ),
                  _CartNavItem(
                    cartCount: controller.cartCount,
                    currentIndex: controller.currentNavIndex.value,
                    onTap: () => controller.setNavIndex(2),
                  ),
                  _NavItem(
                    icon: Icons.favorite_border_rounded,
                    activeIcon: Icons.favorite_rounded,
                    label: 'Wishlist',
                    index: 3,
                    currentIndex: controller.currentNavIndex.value,
                    onTap: () => controller.setNavIndex(3),
                    activeColor: AppColors.errorRed,
                  ),
                  _NavItem(
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Profile',
                    index: 4,
                    currentIndex: controller.currentNavIndex.value,
                    onTap: () => controller.setNavIndex(4),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;
  final Color? activeColor;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == index;
    final color = activeColor ?? AppColors.royalBlue;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? color : AppColors.textLight,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: isActive ? color : AppColors.textLight,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CartNavItem extends StatelessWidget {
  final int cartCount;
  final int currentIndex;
  final VoidCallback onTap;

  const _CartNavItem({
    required this.cartCount,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == 2;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.royalBlue.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive
                      ? Icons.shopping_bag_rounded
                      : Icons.shopping_bag_outlined,
                  color: isActive ? AppColors.royalBlue : AppColors.textLight,
                  size: 22,
                ),
                const SizedBox(height: 2),
                Text(
                  'Cart',
                  style: AppTextStyles.caption.copyWith(
                    color: isActive ? AppColors.royalBlue : AppColors.textLight,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (cartCount > 0)
            Positioned(
              right: 4,
              top: -2,
              child: Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: AppColors.saleRed,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    cartCount > 9 ? '9+' : '$cartCount',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
